from database.models.exportModel import masterWebsite, userInfo, userWishlist, scrapeWish
import wishlistScript
import time


def get_active_wish():
    try:
        user_wish_list = userWishlist.objects(isActive=True).all()

        for userWish in user_wish_list:
            try:
                masterWS = userWish["masterWebsiteId"]
                info = wishlistScript.startWith(masterWS, userWish.websiteUrl)
                print(info)
                save_wish_scrape(userWish, info)
                info["price"] and userWish.update(scrapePrice=info["price"])
                time.sleep(2)
            except Exception as err:
                print(err)

    except Exception as err:
        print(err)


def save_wish_scrape(productInfo, scrapeData):

    if(len(productInfo["targetPrice"])):
        min_target_price = productInfo["targetPrice"][0]
        max_target_price = productInfo["targetPrice"][1]

    body = {
        "userInfoId": productInfo["userInfoId"],
        "masterWebsiteId": productInfo["masterWebsiteId"],
        "userWishlistId": productInfo["id"],
        "domainName": productInfo["domainName"],
        "websiteUrl": productInfo["websiteUrl"],
        "name": productInfo["name"],
        "scrapePrice": scrapeData["price"]
    }
    if(min_target_price <= scrapeData["price"] <= max_target_price):
        body["pushNotification"] = True
    else:
        body["pushNotification"] = False

    scrapeWish(**body).save()
