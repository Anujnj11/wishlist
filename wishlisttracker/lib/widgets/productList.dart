import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:wishlisttracker/models/userInfo.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/utility/getDeviceInfo.dart';
import 'package:wishlisttracker/widgets/wishListW.dart';

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  bool callAPI = true;
  UserInfo objU;
  List<Wishlist> objWish;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 5), getWishlist);
    });
  }

  getWishlist() async {
    print("Inside getWishlist");
    String deviceId = await DeviceInfo().getDeviceId();
    print("deviceId inside product list " + deviceId);
    getwishList(deviceId);
  }

  getwishList(String deviceId) async {
    List<Wishlist> tempO = await Wishlist().getWishlist(deviceId);
    setState(() {
      objWish = tempO;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (objWish == null || objWish.length == 0)
      return Text("EMPTY");
    else
      return WishListW(objWish);
  }
}
