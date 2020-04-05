// import 'package:fl_chart/fl_chart.dart';
import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:wishlisttracker/models/wishlistHistory.dart';

class PriceHistory extends StatefulWidget {
  final List<WishlistHistory> objWHistory;

  PriceHistory(this.objWHistory);
  @override
  PriceHistoryState createState() => PriceHistoryState();
}

class PriceHistoryState extends State<PriceHistory> {
  final fromDate = DateTime(2020, 03, 27);
  final toDate = DateTime.now();

  final date1 = DateTime(2020, 03, 27);
  final date3 = DateTime(2020, 03, 27);
  final date2 = DateTime(2020, 03, 28);

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
            fromDate: fromDate,
            toDate: toDate,
            series: [
              BezierLine(
                data: [
                  DataPoint<DateTime>(value: 50, xAxis: date1),
                  DataPoint<DateTime>(value: 80, xAxis: date3),
                  DataPoint<DateTime>(value: 70, xAxis: date2),
                ],
              ),
            ],
            config: BezierChartConfig(
              verticalIndicatorStrokeWidth: 5.0,
              showVerticalIndicator: true,
              snap: true,
              displayYAxis: true,
              showDataPoints: true,
              stepsYAxis: 5,
              contentWidth: MediaQuery.of(context).size.width * 2,
              startYAxisFromNonZeroValue: true,
            ),
          ),
        ),
      ),
    ]);
  }
}
