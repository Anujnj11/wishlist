import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/userInfo.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/screen/howToInfo.dart';
import 'package:wishlisttracker/widgets/wishListW.dart';

class ProductList extends StatefulWidget {
  final List<Wishlist> objWish;
  ProductList(this.objWish, {Key key}) : super(key: key);
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool callAPI = true;
  UserInfo objU;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Wishlist> pWish = widget.objWish;
    bool showHow = Provider.of<UserInfo>(context, listen: true).getshowHow;
    if (showHow) {
      return HowToInfo();
    } else if (pWish == null || pWish.length == 0) {
      return emptyWisList();
    } else {
      return WishListW(pWish);
    }
  }

  Widget emptyWisList() {
    return Expanded(
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/searchuser.png",
                  height: 250.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, bottom: 2.0),
                child: Text(
                  "No recent added ",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 26.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text(
                  "Your recent added will appear here",
                  style: TextStyle(color: Colors.grey, fontSize: 18.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(35.0),
                child: Container(
                  height: 40.0,
                  width: 90.0,
                  child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.sync,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {
                        Provider.of<Wishlist>(context, listen: true)
                            .getWishlistProvider();
                      }),
                  // onPressed: ()=>)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
