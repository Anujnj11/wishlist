
from datetime import datetime
from .db import db
from .exportModel import userInfo, masterWebsite



class userWishlist(db.Document):
    userInfo = db.ReferenceField(userInfo, required=True)
    masterWebsiteId = db.ReferenceField(masterWebsite)
    domainName = db.StringField()
    websiteUrl = db.URLField()
    currentPrice = db.StringField()
    currentRating = db.StringField()
    targetPrice = db.ListField(db.StringField())
    targetPriceInPer = db.StringField()
    validTillDate = db.DateTimeField(default=datetime.now())
    pushNotification = db.BooleanField()
    wishImages = db.ListField(db.URLField())
    notes = db.StringField()
    negativeReview = db.ListField(db.StringField())
    positiveReview = db.ListField(db.StringField())
    isActive = db.BooleanField()
    createdAt = db.DateTimeField(default=datetime.now())

