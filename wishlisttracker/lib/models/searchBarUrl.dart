import 'package:wishlisttracker/utility/apiCalling.dart';

class SearchBarURL {
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

  SearchBarURL.initial()
      : id = "0",
        productUrl = '',
        image = '',
        price = "0",
        productName = '',
        rating = "";

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

  Future<SearchBarURL> getProductInfo(productUrl) async {
    var reqBody = {"websiteUrl": productUrl};

    var dynamicBody = await ApiCalling.postReq('getPrice', reqBody);
    return SearchBarURL.fromJson(dynamicBody);
  }
}
