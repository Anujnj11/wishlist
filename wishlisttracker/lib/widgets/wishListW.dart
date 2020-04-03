import 'package:flutter/material.dart';
import 'package:wishlisttracker/models/products.dart';
import 'package:wishlisttracker/models/wishlist.dart';

class WishListW extends StatefulWidget {
  final List<Wishlist> objWish;
  WishListW(this.objWish, {Key key})
      : super(key: key); //add also..example this.abc,this...
  @override
  WishListWState createState() => WishListWState();
}

class WishListWState extends State<WishListW> {
  @override
  void initState() {
    super.initState();
  }

  Text _buildRatingStars(String rating) {
    double r = double.parse(rating);
    int rr = r.toInt();
    String stars = '';
    for (int i = 0; i < rr; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    List<Wishlist> objWish = widget.objWish;
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
          itemCount: objWish.length,
          itemBuilder: (BuildContext context, int index) {
            Wishlist objW = objWish[index];
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
                                objW.name,
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
                                  '\Rs ${objW.currentPrice}',
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
                        _buildRatingStars(objW.currentRating),
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
                          '${objW.perChange}%',
                          style: TextStyle(
                            fontSize: 29.0,
                            fontWeight: FontWeight.w500,
                            color: objW.perChange > 0
                                ? Color(4281320352)
                                : Color(4294605964),
                          ),
                        ),
                        Text(
                          objW.perChange > 0 ? "Price down" : "Price up",
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
