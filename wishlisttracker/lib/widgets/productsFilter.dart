import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsFilter extends StatefulWidget {
  @override
  _ProductsFilterState createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {
  List<dynamic> supportedVendor = [];
  @override
  void initState() {
    super.initState();
    _setSupportedVendor();
  }

//
  void _setSupportedVendor() {
    supportedVendor
        .add({"initial": "A", "vendorName": "Amazon", "logoColor": 4294158407});
    supportedVendor.add(
        {"initial": "F", "vendorName": "Flipkart", "logoColor": 4280841456});
    supportedVendor
        .add({"initial": "M", "vendorName": "Myntra", "logoColor": 4280841456});
    supportedVendor
        .add({"initial": "J", "vendorName": "JABONG", "logoColor": 4280841456});
    supportedVendor
        .add({"initial": "J", "vendorName": "JABONG", "logoColor": 4280841456});
    supportedVendor
        .add({"initial": "J", "vendorName": "JABONG", "logoColor": 4280841456});
    supportedVendor
        .add({"initial": "J", "vendorName": "JABONG", "logoColor": 4280841456});
  }

  Widget getVendorChip(vendorObj) {
    return Padding(
      padding: EdgeInsets.only(right: 5.0),
      child: Chip(
        avatar: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          child: Text(
            vendorObj["initial"],
            style: TextStyle(
                fontSize: 20.0,
                color: Color(vendorObj["logoColor"]), //Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.w700),
          ),
        ),
        label: Text(
          vendorObj["vendorName"],
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            height: 40,
            padding: EdgeInsets.only(left: 5.0),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: supportedVendor.length,
                itemBuilder: (context, index) {
                  var vendorType = supportedVendor[index];
                  return getVendorChip(vendorType);
                })),
        Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                "Supported Vendor",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        )
      ],
    );
  }
}
