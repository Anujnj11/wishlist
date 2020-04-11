import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/animation/fadeIn.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/models/userInfo.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import 'package:wishlisttracker/widgets/expandedSection.dart';
import 'package:wishlisttracker/widgets/profile.dart';
import 'package:wishlisttracker/widgets/searchBar.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'howTo.dart';

class HomeScreenHeader extends StatefulWidget {
  @override
  _HomeScreenHeaderState createState() => _HomeScreenHeaderState();
}

class _HomeScreenHeaderState extends State<HomeScreenHeader> {
  bool fieldsUp = false;

  SearchBarURL searchBarD;
  RangeValues values; //= RangeValues(1, 100);
  RangeLabels labels; //= RangeLabels('1', '100');
  bool showInfo = true;
  TextEditingController _productName;
  TextEditingController _productPrice;
  double masterBasePer = 0.5;
  double minDragValue = 1.0;
  double maxDragValue = 100.0;

  final RoundedLoadingButtonController _saveBtnController =
      new RoundedLoadingButtonController();
  final RoundedLoadingButtonController _updateBtnController =
      new RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    _productName = new TextEditingController();
    _productPrice = new TextEditingController();
    values = RangeValues(1, 100);
    labels = RangeLabels('1', '100');
  }

  changeRange(double price) {
    double minPrice = masterBasePer * price;
    double basePrice = price;
    values = RangeValues(minPrice, basePrice);
    labels =
        RangeLabels(minPrice.toInt().toString(), basePrice.toInt().toString());
    setState(() {
      minDragValue = minPrice;
      maxDragValue = basePrice;
    });
  }

  editRange(SearchBarURL searchBarD) {
    double price = double.tryParse(searchBarD.price);
    double minStartPrice = masterBasePer * price;
    double maxbasePrice = price;

    double minPrice = double.tryParse(searchBarD.targetPrice[0]);
    double basePrice = double.tryParse(searchBarD.targetPrice[1]);
    values = RangeValues(minPrice, basePrice);
    labels =
        RangeLabels(minPrice.toInt().toString(), basePrice.toInt().toString());
    _productPrice.text = searchBarD.price;

    setState(() {
      minDragValue = minStartPrice;
      maxDragValue = maxbasePrice;
    });
  }

  updateText(SearchBarURL searchBarD) {
    _productName.text = searchBarD.productName;
    _productPrice.text = searchBarD.price;
    if (searchBarD.id == null &&
        searchBarD.price != null &&
        searchBarD.price != "") {
      changeRange(double.parse(searchBarD.price));
    }
    if (searchBarD.targetPrice != null && searchBarD.targetPrice.length > 0) {
      editRange(searchBarD);
    }
    setState(() {
      fieldsUp = true;
    });
  }

  clearFields() {
    Provider.of<SearchBarURL>(context, listen: false).resetSearchedUrl();
    setState(() {
      fieldsUp = false;
      showInfo = true;
    });
    _productName.clear();
    _productPrice.clear();

    values = RangeValues(1, 100);
    labels = RangeLabels('1', '100');
  }

  void saveWish(UserInfo userInfo, SearchBarURL objSearched) async {
    DateTime currentDate = DateTime.now();
    currentDate = currentDate.add(Duration(days: 365));
    var reqBody = {
      "userInfoId": userInfo.id,
      "masterWebsiteId": objSearched.masterWebsiteId,
      "domainName": objSearched.domainName,
      "websiteUrl": objSearched.productUrl,
      "name": _productName.text,
      "currentPrice": _productPrice.text,
      "currentRating": objSearched.rating,
      "validTillDate": currentDate.toString(),
      "targetPrice": [values.start.toString(), values.end.toString()],
      "scrapePrice": _productPrice.text,
    };
    await SearchBarURL().saveWishList(reqBody);
    showInfo = false;
    _saveBtnController.success();
    clearFields();
    Provider.of<Wishlist>(context, listen: false).getWishlistProvider();
  }

  void updateWish(UserInfo userInfo, SearchBarURL objSearched) async {
    var reqBody = {
      "userInfoId": userInfo.id,
      "id": objSearched.id,
      "currentPrice": _productPrice.text,
      "name": _productName.text,
      "targetPrice": [values.start.toString(), values.end.toString()],
      "isActive": objSearched.isActive,
      "pushNotification": objSearched.pushNotification,
    };

    await SearchBarURL().updateWish(reqBody);
    showInfo = false;
    _updateBtnController.success();
    clearFields();
    Provider.of<Wishlist>(context, listen: false).getWishlistProvider();
  }

  @override
  Widget build(BuildContext context) {
    bool isSeaching = Provider.of<SearchBarURL>(context).isSearching;
    searchBarD =
        Provider.of<SearchBarURL>(context, listen: true).getSearchedUrl();
    if (searchBarD != null && !fieldsUp) updateText(searchBarD);
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: FadeIn(
            0.4,
            Container(
                // height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[HowTo(), Profile()],
                      ),
                      if (!fieldsUp)
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[SearchBar()],
                          ),
                        ),
                      if (isSeaching || fieldsUp)
                        ExpandedSection(
                            expand: showInfo,
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.70,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      if (fieldsUp)
                                        Row(
                                          textDirection: TextDirection.ltr,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5.0),
                                              child: ButtonTheme(
                                                height: 40.0,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: RaisedButton(
                                                  color: Colors.white,
                                                  textColor: Colors.black,
                                                  onPressed: () {
                                                    clearFields();
                                                  },
                                                  child: Text("Close"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 40.0,
                                              width: 90.0,
                                              child: RoundedLoadingButton(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Text(
                                                    searchBarD.id != null
                                                        ? 'Update'
                                                        : 'Save',
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .accentColor)),
                                                controller:
                                                    searchBarD.id != null
                                                        ? _updateBtnController
                                                        : _saveBtnController,
                                                onPressed: () {
                                                  UserInfo userIn =
                                                      Provider.of<UserInfo>(
                                                              context,
                                                              listen: false)
                                                          .getUserInfo;
                                                  searchBarD.id != null
                                                      ? updateWish(
                                                          userIn, searchBarD)
                                                      : saveWish(
                                                          userIn, searchBarD);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextField(
                                              readOnly:
                                                  searchBarD?.productName !=
                                                          null
                                                      ? false
                                                      : true,
                                              controller: _productName,
                                              // TextEditingController(
                                              //     text: searchBarD?.productName),
                                              style: TextStyle(
                                                  height: 0.9,
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                suffixIcon: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: searchBarD == null
                                                      ? CircularProgressIndicator(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        )
                                                      : Text(""),
                                                ),
                                                labelText: "Product Name",
                                                labelStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: TextField(
                                              readOnly: searchBarD?.price != ""
                                                  ? true
                                                  : false,
                                              controller: _productPrice,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  double v =
                                                      double.parse(value);
                                                  changeRange(v);
                                                });
                                              },
                                              style: TextStyle(
                                                  height: 0.9,
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                suffixIcon: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: searchBarD == null
                                                      ? CircularProgressIndicator(
                                                          backgroundColor:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        )
                                                      : Text(""),
                                                ),
                                                labelText: "Product Price",
                                                fillColor: Colors.white,
                                                labelStyle: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide(),
                                                ),
                                                hintText:
                                                    searchBarD?.price != ""
                                                        ? ""
                                                        : "Product price",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                //fillColor: Colors.green
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 12.0),
                                                  child: Text(
                                                    "Expected Price",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  ),
                                                ),
                                                RangeSlider(
                                                  min:
                                                      minDragValue, //_getMinFlag(),
                                                  max:
                                                      maxDragValue, //_getMaxFlag(),
                                                  values: values,
                                                  onChangeStart: (value) {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                  },
                                                  divisions: 50,
                                                  labels: labels,
                                                  activeColor: Theme.of(context)
                                                      .primaryColor, //Color(4281320352),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      print(value);
                                                      values = value;
                                                      labels = RangeLabels(
                                                          '₹${value.start.toInt().toString()}',
                                                          '₹${value.end.toInt().toString()}');
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
