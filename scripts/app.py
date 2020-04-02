import json
import os
from flask import Flask
from flask import Flask, jsonify, request, Response
from database.models.db import initialize_db
from database.models.exportModel import masterWebsite, userInfo, userWishlist
import wishlistScript
import firebaseNotification
from tldextract import tldextract
from bson import ObjectId
import re


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
            if masterWS:
                info = wishlistScript.startWith(masterWS, urlS[0])
                info["statusCode"] = 1
                info["productUrl"] = urlS[0]
                info["masterWebsiteId"] = str(masterWS["id"])
                info["domainName"] = str(masterWS["domainName"])
                return info, 200
            else:
                info["statusCode"] = 0
                info["msg"] = "Product not supported"
                return info, 200
        else:
            info["statusCode"] = 0
            info["msg"] = "Require Url"
            return info, 200
    except Exception as err:
        print(err)
        return {'id': err}, 500


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
        return Response({'statusCode': "0"}, mimetype="application/json", status=500)


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


@app.route('/getProduct', methods=['POST'])
def get_product():
    try:
        body = request.get_json()
        user_wish_list = userWishlist.objects(
            userInfoId=ObjectId(body["userInfoId"])).all()
        return Response(user_wish_list.to_json(), mimetype="application/json", status=200)
    except Exception as err:
        print(err)
        return Response({'statusCode': 0}, mimetype="application/json", status=500)

# @app.route('/movies/<id>', methods=['PUT'])
# def update_movie(id):
#     body = request.get_json()
#     Movie.objects.get(id=id).update(**body)
#     return '', 200

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
