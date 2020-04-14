import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wishlisttracker/animation/fadeIn.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/models/wishlistHistory.dart';
import 'package:wishlisttracker/widgets/priceHistory.dart';
import 'package:wishlisttracker/widgets/swipeButton.dart';

class WishlistDetails extends StatefulWidget {
  final Wishlist wishObj;

  WishlistDetails({this.wishObj});

  @override
  WishlistDetailsState createState() => WishlistDetailsState();
}

class WishlistDetailsState extends State<WishlistDetails> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<WishlistHistory>(context, listen: false)
        .getWishlistHistory(widget.wishObj.id));
  }

  void getPriceHistory() {
    String userWishId = widget.wishObj.id;
    WishlistHistory().getWishlistHistory(userWishId);
  }

  @override
  Widget build(BuildContext context) {
    List<WishlistHistory> wishHistory =
        Provider.of<WishlistHistory>(context, listen: true).getWishListHistory;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[PriceHistory(widget.wishObj, wishHistory)],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Text(
                        widget.wishObj.name,
                        style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FadeIn(
                      0.9,
                      Container(
                        width: 120,
                        height: 150,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor, // border color
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${widget.wishObj.perChange}%',
                              style: TextStyle(
                                fontSize: 29.0,
                                fontWeight: FontWeight.w500,
                                color: widget.wishObj.perChange > 0
                                    ? Color(4281320352)
                                    : Color(4294605964),
                              ),
                            ),
                            Text(
                              widget.wishObj.perChange > 0
                                  ? "Price down"
                                  : "Price up",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    FadeIn(
                      0.9,
                      Container(
                        width: 120,
                        height: 150,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor, // border color
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '₹ ${widget.wishObj.scrapePrice}',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              "Current Price",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    FadeIn(
                      0.9,
                      Container(
                        width: 120,
                        height: 150,
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor, // border color
                          shape: BoxShape.rectangle,
                          // border: Border.all(
                          // color: Theme.of(context).primaryColor, width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '${widget.wishObj.currentRating}',
                              style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.yellow.shade800,
                              ),
                            ),
                            Text(
                              "Rating",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(24.0),
                  child: SwipeButton(
                    thumb: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Align(
                            widthFactor: 0.90,
                            child: Icon(
                              Icons.chevron_right,
                              size: 60.0,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    content: Center(
                      child: Text(
                        'Swipe To Navigate To Page',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    onChanged: (result) {
                      launch(widget.wishObj.websiteUrl);
                    },
                  ),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
