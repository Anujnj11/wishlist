import json
import os
from flask import Flask
from flask import Flask, jsonify, request, Response
from database.models.db import initialize_db
from database.models.exportModel import masterWebsite, userInfo, userWishlist, scrapeWish
import wishlistScript
import firebaseNotification
from tldextract import tldextract
from bson import ObjectId, json_util
import re
import userWishScrape
import scheduler

app = Flask(__name__)
app.config['DEBUG'] = False


app.config['MONGODB_SETTINGS'] = {
    'host': "mongodb://wishlistapp:wishlistpassword007@ds141813.mlab.com:41813/wishlist?retryWrites=false"
}

initialize_db(app)


@app.route("/")
def isActive():
    return "Hello!"

# @app.route('/movies')
# def get_movies():
#     movies = Movie.objects().to_json()
#     return Response(movies, mimetype="application/json", status=200)


@app.route('/addMaster', methods=['POST'])
def add_master():
    try:
        body = request.get_json()
        movie = masterWebsite(**body).save()
        id = movie.id
        return {'id': str(id)}, 200
    except Exception as err:
        print(err)
        return {'id': err}, 500


@app.route('/getPrice', methods=['POST'])
def get_price():
    try:
        body = request.get_json()
        if body["websiteUrl"]:
            urlS = re.findall(
                "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\(\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+", body["websiteUrl"])
            url = urlS and len(urlS) and urlS[0]
            url = tldextract.extract(url)
            masterWS = get_domain_obj(url.domain)
            info = {}
            if masterWS:
                info = wishlistScript.startWith(masterWS, urlS[0])
                info["statusCode"] = 1
                info["productUrl"] = urlS[0]
                info["masterWebsiteId"] = str(masterWS["id"])
                info["domainName"] = str(masterWS["domainName"])
                return info
            else:
                info["statusCode"] = 0
                info["msg"] = "Product not supported"
                return info
        else:
            info["statusCode"] = 0
            info["msg"] = "Require Url"
            return info
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


def get_domain_obj(domainName):
    try:
        objmasterW = masterWebsite.objects.get(domainName=domainName)
        return objmasterW
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/userToken', methods=['POST'])
def update_user():
    try:
        body = request.get_json()
        new_user = userInfo.objects(deviceId=body["deviceId"]).modify(upsert=True, new=True,
                                                                      set__deviceId=body["deviceId"],
                                                                      set__firebaseId=body["firebaseId"],
                                                                      )
        userInfoD = {
            "id": str(new_user.id),
            "deviceId": new_user.deviceId,
            "firebaseId": new_user.firebaseId,
            "statusCode": 1
        }
        userInfoD = json.dumps(userInfoD)
        return Response(userInfoD, mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/addProduct', methods=['POST'])
def add_product():
    try:
        body = request.get_json()
        body["userInfoId"] = ObjectId(body["userInfoId"])
        body["masterWebsiteId"] = ObjectId(body["masterWebsiteId"])

        newUserList = userWishlist(**body).save()
        return Response(newUserList.to_json(), mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/updateProduct', methods=['POST'])
def update_product():
    try:
        body = request.get_json()
        update_product = userWishlist.objects(id=ObjectId(body["id"])).modify(upsert=True, new=False,
                                                                              set__name=body["name"],
                                                                              set__targetPrice=body["targetPrice"],
                                                                              set__currentPrice=body["currentPrice"],
                                                                              set__isActive=body["isActive"],
                                                                              set__pushNotification=body["pushNotification"]
                                                                              )
        if update_product:
            update_product = {"statusCode": 1}

        update_product = json.dumps(update_product)
        return Response(update_product, mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/getProduct', methods=['POST'])
def get_product():
    try:
        body = request.get_json()
        deviceId = userInfo.objects.filter(deviceId=body["deviceId"]).first()
        if deviceId:
            user_wish_list = userWishlist.objects(
                userInfoId=deviceId.id, isActive=True).all()
            user_wish_list = user_wish_list.to_json()
        else:
            user_wish_list = []
        return Response(user_wish_list, mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/scrapeUserWish', methods=['GET'])
def scrape_User_wish():
    try:
        userWishScrape.get_active_wish()
        return Response({"statusCode": 1}, mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/getWishHistory', methods=['POST'])
def get_wish_history():
    try:
        body = request.get_json()
        pipeline = [
            {'$match': {'userWishlistId': ObjectId(body["userWishlistId"])}},
            {'$group': {'_id': {'$dateToString': {'format': '%Y-%m-%d', 'date': '$createdAt'}},
                        'minPrice': {'$min': '$scrapePrice'}, 'doc': {'$first': '$$ROOT'}}},
            {'$replaceRoot': {'newRoot': '$doc'}},
            {'$sort': {'createdAt': 1}}
        ]
        wish_list_history = list(scrapeWish.objects().aggregate(pipeline))
        wish_list_history = json.dumps(
            wish_list_history, default=json_util.default)
        return Response(wish_list_history, mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)


@app.route('/sendNotification', methods=['GET'])
def sendNotification():
    token = request.args["token"]
    firebaseNotification.send_to_token(token, "Hello", "Bodyyyyyy")
    return Response({"statu": "1"}, mimetype="application/json", status=200)


@app.route('/get_master_website', methods=['GET'])
def get_master_website():
    master_list = masterWebsite.objects(isActive=True).all()
    master_list = master_list.to_json()
    return Response(master_list, mimetype="application/json", status=200)

# @app.route('/movies/<id>', methods=['DELETE'])
# def delete_movie(id):
#     movie = Movie.objects.get(id=id).delete()
#     return '', 200

# @app.route('/movies/<id>')
# def get_movie(id):
#     movies = Movie.objects.get(id=id).to_json()
#     return Response(movies, mimetype="application/json", status=200)


if __name__ == '__main__':
    import os
    port = int(os.environ.get('PORT', 33507))
    app.run(host='0.0.0.0', port=port)
