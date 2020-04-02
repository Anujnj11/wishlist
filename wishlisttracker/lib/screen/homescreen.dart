import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/widgets/productsFilter.dart';
import 'package:flutter/material.dart';
import 'package:wishlisttracker/widgets/homeScreenHeader.dart';
import 'package:wishlisttracker/widgets/productList.dart';
import 'package:wishlisttracker/utility/getDeviceInfo.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamSubscription _intentDataStreamSubscription;
  DeviceInfo diObj = new DeviceInfo();
  String _sharedText;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _setOtherUtility(context);
      sharingUrl();
    });
  }

  void _setOtherUtility(context) {
    diObj.init(context);
  }

  setProductUrl(value) {
    if (value != null && value != "") {
      setState(() {
        _sharedText = value;
      });
    }
  }

  sharingUrl() {
    // For sharing or opening urls/text coming from outside the app while the app is in the memory
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
  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_sharedText != "" && _sharedText != null) {
      Provider.of<SearchBarURL>(context, listen: false)
          .getProductInfo(_sharedText);
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top - 2),
          HomeScreenHeader(),
          SizedBox(height: 10),
          ProductsFilter(),
          ProductList(),
        ],
      ),
    );
  }
}
