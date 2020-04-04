import 'package:flutter/material.dart';
import 'package:wishlisttracker/models/userInfo.dart';
import 'package:wishlisttracker/models/wishlist.dart';
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
    return pWish == null || pWish.length == 0
        ? Text("EMPTY")
        : WishListW(pWish);
  }
}
