import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class SearchBarURL extends ChangeNotifier {
  bool _searching = false;
  SearchBarURL _searchedUrl;

  String id;
  String productUrl;
  String image;
  String price;
  String productName;
  String rating;
  String masterWebsiteId;

  SearchBarURL.initial()
      : id = "0",
        productUrl = '',
        image = '',
        price = "0",
        productName = '',
        rating = "",
        masterWebsiteId = "";

  SearchBarURL(
      {this.id,
      this.price,
      this.productName,
      this.image,
      this.productUrl,
      this.rating,
      this.masterWebsiteId});

  bool get isSearching => _searching;

  SearchBarURL get getSearchedUrl => _searchedUrl;

  SearchBarURL.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      productUrl = json['productUrl'];
      image = json['image'];
      price = json['price'];
      productName = json['productName'];
      rating = json['rating'];
      masterWebsiteId = json['masterWebsiteId'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productUrl'] = this.productUrl;
    data['image'] = this.image;
    data['productName'] = this.productName;
    data['rating'] = this.rating;
    return data;
  }

  void getProductInfo(productUrl) async {
    var reqBody = {"websiteUrl": productUrl};
    setSearching(true);
    var dynamicBody = await ApiCalling.postReq('getPrice', reqBody);
    if (dynamicBody != null) {
      _searchedUrl = SearchBarURL.fromJson(dynamicBody);
    } else {
      _searchedUrl = new SearchBarURL();
    }
    setSearching(false);
  }

  void setSearching(isSearching) {
    _searching = isSearching;
    notifyListeners();
  }

  void resetSearchedUrl() {
    _searchedUrl = null;
    _searching = false;
    notifyListeners();
  }
}
