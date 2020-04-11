import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/animation/fadeIn.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/screen/wishlistDetails.dart';

class WishListW extends StatefulWidget {
  final List<Wishlist> objWish;
  WishListW(this.objWish, {Key key})
      : super(key: key); //add also..example this.abc,this...
  @override
  WishListWState createState() => WishListWState();
}

class WishListWState extends State<WishListW> {
  List<dynamic> actionList = [];

  @override
  void initState() {
    super.initState();
    setActionList();
  }

  setActionList() {
    actionList.add({"title": "Edit"});
    actionList.add({"title": "Delete"});
    actionList.add({"title": "Share"});
    actionList.add({"title": "Change Notification"});
  }

  editUserWish(Wishlist obj) {
    SearchBarURL objSeach = new SearchBarURL();
    objSeach.id = obj.id;
    objSeach.productName = obj.name;
    objSeach.targetPrice = obj.targetPrice;
    objSeach.price = obj.scrapePrice;
    objSeach.validTillDate = obj.validTillDate;
    objSeach.isActive = obj.isActive;
    objSeach.pushNotification = obj.pushNotification;
    Provider.of<SearchBarURL>(context, listen: false).editWish(objSeach);
  }

  Widget _modalBottomSheetMenu(actionObj, Wishlist obj) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        print(actionObj["title"]);
        editUserWish(obj);
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 5.0),
          child: Container(
            height: 50.0,
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: Center(
              child: Text(actionObj["title"],
                  style:
                      TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500)),
            ),
          ),
        ),
      ),
    );
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
    List<Wishlist> objWish =
        widget.objWish != null ? widget.objWish : new List<Wishlist>();
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.only(top: 5.0, bottom: 15.0),
          itemCount: objWish.length,
          itemBuilder: (BuildContext context, int index) {
            Wishlist objW = objWish[index];
            return FadeIn(
              0.5,
              Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(70.0, 5.0, 20.0, 1.0),
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
                      padding: EdgeInsets.fromLTRB(75.0, 0.0, 10.0, 1.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => WishlistDetails(
                                        wishObj: objW,
                                      ),
                                    ),
                                  ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            '\₹ ${objW.currentPrice}',
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
                                ],
                              )),
                          GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    // Theme.of(context).accentColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0)),
                                    ),
                                    context: context,
                                    builder: (builder) {
                                      return Container(
                                          height: 250.0,
                                          color: Colors.transparent,
                                          child: ListView.builder(
                                              itemCount: actionList.length,
                                              itemBuilder: (context, index) {
                                                var actionType =
                                                    actionList[index];
                                                return _modalBottomSheetMenu(
                                                    actionType, objW);
                                              }));
                                    });
                              },
                              child: Container(
                                height: 25.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.chevronCircleDown,
                                      color: Colors.grey.shade300,
                                      size: 21.0,
                                    ),
                                  ],
                                ),
                              ))
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
              ),
              // ),
            );
          }),
    );
  }
}
