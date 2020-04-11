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
    actionList
        .add({"action": "EDIT", "title": "Edit wish", "icon": Icons.edit});
    actionList.add({
      "action": "DELETE",
      "title": "Delete wish",
      "meta": "Are you sure want to delete wish?",
      "icon": Icons.delete_outline
    });
    // actionList.add(
    //     {"action": "SHARE", "title": "Share with others", "icon": Icons.share});
    // actionList.add({
    //   "action": "NOTI",
    //   "title": "Change Notification",
    //   "icon": Icons.notifications_active
    // });
  }

  deleteUserWish(Wishlist obj) async {
    var reqBody = {
      "userInfoId": obj.userInfoId,
      "id": obj.id,
      "currentPrice": obj.scrapePrice,
      "name": obj.name,
      "targetPrice": obj.targetPrice,
      "isActive": false,
      "pushNotification": false,
    };
    await SearchBarURL().updateWish(reqBody);
    Provider.of<Wishlist>(context, listen: false).getWishlistProvider();
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

  AlertDialog editAlert(actionObj, Wishlist obj) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Text(
        actionObj["action"] + " WISH",
        style: TextStyle(fontSize: 18.0),
      ),
      titlePadding: EdgeInsets.all(10.0),
      content: Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
        child: Text(actionObj["meta"],
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.w500)),
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Text("Yes"),
                onPressed: () {
                  deleteUserWish(obj);
                  Navigator.pop(context);
                },
                textColor: Theme.of(context).accentColor,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _modalBottomSheetMenu(actionObj, Wishlist obj) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        String actionType = actionObj["action"];
        switch (actionType) {
          case "EDIT":
            editUserWish(obj);
            break;
          case "DELETE":
          case "NOTI":
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return editAlert(actionObj, obj);
              },
            );
            break;
          default:
            print("Noting");
        }
      },
      child: Container(
        child: Padding(
          padding: EdgeInsets.fromLTRB(5.0, 20.0, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Icon(
                  actionObj["icon"],
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
              Text(actionObj["title"],
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).scaffoldBackgroundColor))
            ],
          ),
        ),
      ),
    );
  }

  Text _buildRatingStars(String rating) {
    return Text(
      "⭐ " + rating,
      style: TextStyle(fontSize: 18.0, color: Colors.grey),
    );
  }

  Widget _trackNotification(dynamic trackPrice) {
    double priceStart = double.parse(trackPrice[0]);
    double priceEnd = double.parse(trackPrice[1]);
    int pS = priceStart.toInt();
    int pE = priceEnd.toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: Icon(
            FontAwesomeIcons.bell,
            size: 16.0,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 1.0),
          child: Row(
            children: <Widget>[
              Text(
                "₹ " + pS.toString(),
                style: TextStyle(fontSize: 17.0),
              ),
              Text(" - "),
              Text(
                "₹ " + pE.toString(),
                style: TextStyle(fontSize: 17.0),
              ),
            ],
          ),
        )
      ],
    );
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _trackNotification(objW.targetPrice),
                                      _buildRatingStars(objW.currentRating),
                                    ],
                                  )
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
                                          height: 125.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15.0),
                                                topLeft: Radius.circular(15.0)),
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
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
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WishlistDetails(
                            wishObj: objW,
                          ),
                        ),
                      ),
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
                  ),
                ],
              ),
              // ),
            );
          }),
    );
  }
}
