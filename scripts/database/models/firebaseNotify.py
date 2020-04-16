
from bson import ObjectId
from .db import db
from datetime import datetime
import requests
import json
registration_token = 'Key=AAAAjVdV8mc:APA91bHyIy8h3Wj1cRbH9g9-wUrS-Yt2I3yep3xl-GEh_LRzuzkHXfDIDq6DGv_4qLtxR98uZHTiPInAuIZgLSTX_EXCXOL9QimETw3AV72evkNkGkM53tlFmf4EdmLluabv9rgpSyuo'


class firebaseNotify(db.Document):
    userInfoId = db.ReferenceField('userInfo', required=True)
    userWishlistId = db.ReferenceField('userWishlist')
    title = db.StringField()
    action = db.StringField()
    message = db.StringField()
    isSuccess = db.BooleanField()
    createdAt = db.DateTimeField(default=datetime.now())

    def send_to_token(this, userInfoD, title, msg, userWishlistId=""):
        try:
            firebaseId = userInfoD["firebaseId"]
            data = {"notification": {"title": title, "body": msg,
                                     "click_action": 'FLUTTER_NOTIFICATION_CLICK'}, "to": firebaseId}
            data_json = json.dumps(data)
            print(data_json)
            headers = {'Content-type': 'application/json',
                       'Authorization': registration_token}

            url = 'https://fcm.googleapis.com/fcm/send'

            response = requests.post(url, data=data_json, headers=headers)

            jsonResponse = json.loads(response.content)
            print(jsonResponse)
        except Exception as err:
            print(err)
        finally:
            body = {
                "userInfoId": userInfoD["id"],
                "title": title,
                "action": "simple",
                "message": msg,
                "isSuccess": jsonResponse["success"]
            }
            if(userWishlistId):
                body["userWishlistId"] = ObjectId(userWishlistId)
            firebaseNotify(**body).save()
