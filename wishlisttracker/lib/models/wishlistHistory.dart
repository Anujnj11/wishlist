import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class WishlistHistory extends ChangeNotifier {
  ValueNotifier<List<WishlistHistory>> wishListHistoryObj;

  String userWishlistId;
  String userInfoId;
  String masterWebsiteId;
  String domainName;
  String websiteUrl;
  String name;
  String scrapePrice;
  bool pushNotification;
  List<dynamic> scrapeNegativeReview;
  List<dynamic> scrapePositiveReview;
  DateTime createdAt;

  WishlistHistory(
      {this.userInfoId,
      this.masterWebsiteId,
      this.domainName,
      this.websiteUrl,
      this.name,
      this.pushNotification,
      this.scrapePrice,
      this.scrapeNegativeReview,
      this.scrapePositiveReview});

  List<WishlistHistory> get getWishListHistory =>
      wishListHistoryObj != null ? wishListHistoryObj.value : [];

  WishlistHistory.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      userWishlistId = json["userWishlistId"]["\$oid"];
      userInfoId = json["_id"]["\$oid"];
      masterWebsiteId = json["userInfoId"]["\$oid"];
      domainName = json["masterWebsiteId"]["\$oid"];
      websiteUrl = json["websiteUrl"];
      name = json["name"];
      pushNotification = json["pushNotification"];
      scrapeNegativeReview = json["scrapeNegativeReview"];
      scrapePositiveReview = json["scrapePositiveReview"];
      scrapePrice = json["scrapePrice"];
      createdAt =
          DateTime.fromMillisecondsSinceEpoch(json["createdAt"]["\$date"]);
    }
  }

  List<WishlistHistory> wishListParser(dynamic responseBody) {
    // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return responseBody
        .map<WishlistHistory>((json) => WishlistHistory.fromJson(json))
        .toList();
  }

  void getWishlistHistory(userWishlistId) async {
    var reqBody = {"userWishlistId": userWishlistId};
    var dynamicBody = await ApiCalling.postReq('getWishHistory', reqBody);
    if (dynamicBody != null) {
      List<WishlistHistory> tempO0 = wishListParser(dynamicBody);
      wishListHistoryObj = new ValueNotifier<List<WishlistHistory>>(tempO0);
      wishListHistoryObj.notifyListeners();
      notifyListeners();
    }

    print("Got history");
  }

  void resetWishlistHistory() {
    wishListHistoryObj = null;
    wishListHistoryObj.notifyListeners();
    notifyListeners();
  }
}
