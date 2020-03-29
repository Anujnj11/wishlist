import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/utility/apiCalling.dart';

class SearchBarURL extends ChangeNotifier {
  SearchBarURL _sampleS;

  String id;
  String productUrl;
  String image;
  String price;
  String productName;
  String rating;

  SearchBarURL(
      {this.id,
      this.price,
      this.productName,
      this.image,
      this.productUrl,
      this.rating});

  SearchBarURL get getData => _sampleS;

  SearchBarURL.fromJson(Map<String, dynamic> json) {
    productUrl = json['productUrl'];
    image = json['image'];
    price = json['price'];
    productName = json['productName'];
    rating = json['rating'];
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

    var dynamicBody = await ApiCalling.postReq('getPrice', reqBody);
    _sampleS = SearchBarURL.fromJson(dynamicBody);
    notifyListeners();
  }
}
