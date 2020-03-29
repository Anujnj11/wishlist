from .db import db


class masterWebsite(db.Document):
    websiteName = db.StringField()
    domainName = db.StringField()
    priceClass = db.StringField()
    imagesClass = db.StringField()
    reviewClass = db.StringField()
    nameClass = db.StringField()
    nameId = db.StringField()
    ratingClass = db.StringField()
    isActive = db.BooleanField(default=True)
