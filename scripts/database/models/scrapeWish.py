
from datetime import datetime
from .db import db
from .exportModel import userInfo, masterWebsite, userWishlist
from mongoengine import *
from mongoengine import signals
import firebaseNotification
from bson import json_util


class scrapeWish(db.Document):
    userInfoId = db.ReferenceField(userInfo, required=True)
    masterWebsiteId = db.ReferenceField(masterWebsite)
    userWishlistId = db.ReferenceField(userWishlist, required=True)
    domainName = db.StringField()
    websiteUrl = db.URLField()
    name = db.StringField()
    scrapePrice = db.StringField()
    pushNotification = db.BooleanField()
    scrapeNegativeReview = db.ListField(db.StringField())
    scrapePositiveReview = db.ListField(db.StringField())
    createdAt = db.DateTimeField(default=datetime.now())

    @classmethod
    def post_save(cls, sender, document, **kwargs):
        try:
            if 'created' in kwargs:
                if kwargs['created']:
                    print("Created Scrape User")
                    push_notification = document["pushNotification"]
                    if push_notification:
                        firebaseId = document["userInfoId"]["firebaseId"]
                        title = "Congo Price drop {} 😎".format(
                            document["name"])
                        body = "Navigate to product to buy 🛒"
                        firebaseNotification.send_to_token(
                            firebaseId, title, body)
        except Exception as err:
            print(err)

    # @classmethod
    # def to_json(self):
    #     data = self.to_mongo(self)
    #     return json_util.dumps(data)


    # class JSONEncoder(json.JSONEncoder):
    # @classmethod
    # def JSONEncoder(self, o):
    #     if isinstance(o, ObjectId):
    #         return str(o)
    #     return json.JSONEncoder.default(self, o)


signals.post_save.connect(scrapeWish.post_save, sender=scrapeWish)
