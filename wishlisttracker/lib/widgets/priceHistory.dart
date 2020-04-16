// import 'package:fl_chart/fl_chart.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/models/wishlistHistory.dart';

class PriceHistory extends StatefulWidget {
  final List<WishlistHistory> objWishlist;
  final Wishlist wishObj;

  PriceHistory(this.wishObj, this.objWishlist);
  @override
  PriceHistoryState createState() => PriceHistoryState();
}

class PriceHistoryState extends State<PriceHistory> {
  @override
  void initState() {
    super.initState();
  }

  List<DataPoint<DateTime>> getGraphDate() {
    List<DataPoint<DateTime>> dates = [];
    if (widget.objWishlist.length > 0) {
      for (var i = 0; i < widget.objWishlist.length; i++) {
        WishlistHistory obj = widget.objWishlist[i];
        double price = double.tryParse(obj.scrapePrice);
        price = price != null ? price : 0.0;
        dates.add(DataPoint<DateTime>(value: price, xAxis: obj.createdAt));
      }
    } else {
      double price = double.tryParse(widget.wishObj.scrapePrice);
      dates.add(DataPoint<DateTime>(value: price, xAxis: DateTime.now()));
    }
    return dates;
  }

  DateTime getfromDate() {
    DateTime fromDate = DateTime.now();
    if (widget.objWishlist.length > 0)
      fromDate = widget.objWishlist.first.createdAt;
    //Handling this way since chart fromdate should not be same as todate
    if (widget.objWishlist.length == 1)
      fromDate = fromDate.subtract(Duration(minutes: 1, seconds: 0));
    return fromDate;
  }

  DateTime gettoDate() {
    DateTime toDate = DateTime.now();
    if (widget.objWishlist.length > 0)
      toDate = widget.objWishlist.last.createdAt;
    return toDate;
  }

  @override
  void dispose() {
    // Provider.of<WishlistHistory>(context, listen: false).resetWishlistHistory();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height * 0.45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
            color: const Color(0xff232d37)),
        child: Padding(
          padding:
              EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: BezierChart(
            bezierChartScale: BezierChartScale.WEEKLY,
            fromDate: getfromDate(),
            toDate: gettoDate(),
            series: [
              BezierLine(
                data: getGraphDate(),
              ),
            ],
            config: BezierChartConfig(
              verticalIndicatorStrokeWidth: 5.0,
              showVerticalIndicator: true,
              snap: true,
              displayYAxis: true,
              showDataPoints: true,
            ),
          ),
        ),
      ),
    ]);
  }
}
