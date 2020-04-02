import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/products.dart';
import 'package:wishlisttracker/models/userInfo.dart';
import 'package:wishlisttracker/models/wishlist.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool callAPI = true;
  UserInfo objU;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      // getWishlist(context);
    });
  }

  // getWishlist(context) {
  //   var sampple = Provider.of<UserInfo>(context, listen: false).getUserInfo;
  //   var sampple2 = Provider.of<UserInfo>(context, listen: false).objUserInfo;
  //   print(sampple2);
  // }

  getwishList(UserInfo objU) {
    setState(() {
      callAPI = false;
    });
    Wishlist().getWishlist(objU.id);
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  int _changeInPrice(Product product) {
    var temp = ((product.originalPrice - product.currentPrice) /
            product.originalPrice) *
        100;
    return temp.toInt();
  }

  @override
  Widget build(BuildContext context) {
    UserInfo objU = Provider.of<UserInfo>(context, listen: true).getUserInfo;
    List<Wishlist> objW =
        Provider.of<Wishlist>(context, listen: false).getWishList;
    if (objU != null && callAPI) getwishList(objU);

    print(objW);
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            Product product = products[index];
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(70.0, 5.0, 20.0, 3.0),
                  height: 120.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(75.0, 0.0, 10.0, 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Text(
                                product.title,
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Text(
                                  '\Rs ${product.currentPrice}',
                                  style: TextStyle(
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Current Price',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        _buildRatingStars(product.productRating),
                        SizedBox(height: 25.0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 25.0,
                  top: 10.0,
                  bottom: 10.0,
                  child: Container(
                    width: 100,
                    height: 90,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor, // border color
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                          topLeft: Radius.circular(25)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '${_changeInPrice(product)}%',
                          style: TextStyle(
                            fontSize: 29.0,
                            fontWeight: FontWeight.w500,
                            color: (_changeInPrice(product) > 0)
                                ? Color(4281320352)
                                : Color(4294605964),
                          ),
                        ),
                        Text(
                          (_changeInPrice(product) > 0)
                              ? "Price down"
                              : "Price up",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
