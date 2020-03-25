import json
import os
from flask import Flask
from flask import Flask, jsonify, request, Response
from database.models.db import initialize_db
from database.models.masterWebsite import masterWebsite
import wishlistScript

app = Flask(__name__)
app.config['DEBUG'] = True


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
        masterWS = masterWebsite.objects.get(id=body["websiteMasterId"])
        info = wishlistScript.startWith(masterWS,body["websiteUrl"])
        return info, 200
    except Exception as err:
        print(err)
        return {'id': err}, 500


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
