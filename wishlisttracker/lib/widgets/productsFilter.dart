import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wishlisttracker/animation/fadeIn.dart';
import 'package:wishlisttracker/models/masterWebsite.dart';

class ProductsFilter extends StatefulWidget {
  final List<MasterWebsite> objMaster;
  ProductsFilter(this.objMaster, {Key key}) : super(key: key);
  @override
  _ProductsFilterState createState() => _ProductsFilterState();
}

class _ProductsFilterState extends State<ProductsFilter> {
  @override
  void initState() {
    super.initState();
  }

  Widget getVendorChip(MasterWebsite vendorObj) {
    return GestureDetector(
      onTap: () async {
        await launch(vendorObj.url);
      },
      child: FadeIn(
        0.8,
        Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Chip(
            avatar: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              child: Text(
                vendorObj.chipC,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Color(vendorObj.brandColor),
                    // Color(vendorObj[
                    // "logoColor"]), //Theme.of(context).scaffoldBackgroundColor,
                    fontWeight: FontWeight.w700),
              ),
            ),
            label: Text(
              vendorObj.title,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
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
                itemCount: widget.objMaster.length, //supportedVendor.length,
                itemBuilder: (context, index) {
                  var vendorType =
                      widget.objMaster[index]; //supportedVendor[index];
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
