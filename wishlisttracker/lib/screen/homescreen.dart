import 'package:flutter/scheduler.dart';
import 'package:wishlisttracker/widgets/productsFilter.dart';
import 'package:flutter/material.dart';
import 'package:wishlisttracker/widgets/homeScreenHeader.dart';
import 'package:wishlisttracker/widgets/productList.dart';
import 'package:wishlisttracker/utility/getDeviceInfo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DeviceInfo diObj = new DeviceInfo();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => {_setOtherUtility()});
  }

  void _setOtherUtility() {
    diObj.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top - 2),
          HomeScreenHeader(),
          SizedBox(height: 10),
          ProductsFilter(),
          ProductList()
        ],
      ),
    );
  }
}
