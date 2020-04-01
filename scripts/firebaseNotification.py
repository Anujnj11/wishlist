import requests
import json
registration_token = 'Key=AAAAjVdV8mc:APA91bHyIy8h3Wj1cRbH9g9-wUrS-Yt2I3yep3xl-GEh_LRzuzkHXfDIDq6DGv_4qLtxR98uZHTiPInAuIZgLSTX_EXCXOL9QimETw3AV72evkNkGkM53tlFmf4EdmLluabv9rgpSyuo'


def send_to_token(firebaseId, title, msg):
    data = {"notification": {"title": title,"body": msg}, "to": firebaseId}
    data_json = json.dumps(data)
    print(data_json)
    headers = {'Content-type': 'application/json',
               'Authorization': registration_token}

    url = 'https://fcm.googleapis.com/fcm/send'

    response = requests.post(url, data=data_json, headers=headers)

    jsonResponse = json.loads(response.content)
    print(jsonResponse)
