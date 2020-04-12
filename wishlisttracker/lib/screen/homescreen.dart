import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/widgets/productsFilter.dart';
import 'package:flutter/material.dart';
import 'package:wishlisttracker/widgets/homeScreenHeader.dart';
import 'package:wishlisttracker/widgets/productList.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _intentDataStreamSubscription;
  String _sharedText;
  List<Wishlist> objWish;
  @override
  void initState() {
    super.initState();
    // Future.delayed(duration)
    sharingUrl();

    Future.microtask(() =>
        Provider.of<Wishlist>(context, listen: false).getWishlistProvider());
  }

  setProductUrl(value) {
    if (value != null && value != "") {
      setState(() {
        _sharedText = value;
      });
    }
  }

  sharingUrl() {
    Future.delayed(const Duration(seconds: 3), () {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        print("Getting url");
        _intentDataStreamSubscription =
            ReceiveSharingIntent.getTextStream().listen((String value) {
          if (value != null && value != "") {
            setState(() {
              _sharedText = value;
            });
          }
        }, onError: (err) {
          print("getLinkStream error: $err");
        });

        // For sharing or opening urls/text coming from outside the app while the app is closed
        ReceiveSharingIntent.getInitialText().then((String value) {
          if (value != null && value != "") {
            setState(() {
              _sharedText = value;
            });
          }
        }, onError: (err) {
          print("getLinkStream error: $err");
        });
      });
    });
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  setTextEmpty() {
    Future.delayed(Duration(seconds: 4), () {
      setState(() {
        _sharedText = "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    objWish = Provider.of<Wishlist>(context, listen: true).getWishList;
    if (_sharedText != "" && _sharedText != null) {
      Provider.of<SearchBarURL>(context, listen: false)
          .getProductInfo(_sharedText);
      setTextEmpty();
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top - 2),
          HomeScreenHeader(),
          SizedBox(height: 10),
          ProductsFilter(),
          ProductList(objWish),
        ],
      ),
    );
  }
}
