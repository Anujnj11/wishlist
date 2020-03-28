import 'package:wishlist_tracker/sections/wish_info_screen.dart';
import 'package:wishlist_tracker/sections/wish_list_view.dart';
import 'package:wishlist_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:wishlist_tracker/const/_const.dart';
import 'package:wishlist_tracker/sections/wish_list_2_view.dart';

class WishListTracker extends StatefulWidget {
  @override
  _WishListTrackerState createState() => _WishListTrackerState();
}

class _WishListTrackerState extends State<WishListTracker> {
  CategoryType categoryType = CategoryType.ui;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getSearchBarUI(),
                      getCategoryUI(),
                      Flexible(
                        // child: getPopularCourseUI(),
                        child: WishList2View(
                          callBack: () {
                            moveTo();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Text(
            ConstString.VENDOR,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: AppTheme.darkerText,
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Row(
            children: <Widget>[
              getButtonUI(CategoryType.ui, categoryType == CategoryType.ui),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.coding, categoryType == CategoryType.coding),
              const SizedBox(
                width: 16,
              ),
              getButtonUI(
                  CategoryType.basic, categoryType == CategoryType.basic),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        // CategoryListView(
        //   callBack: () {
        //     moveTo();
        //   },
        // ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ConstString.WISHLIST,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: AppTheme.darkerText,
            ),
          ),
          Flexible(
            child: WishListView(
              callBack: () {
                moveTo();
              },
            ),
          )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => WishInfoScreen(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Amazon';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Flipkart';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'PayTM';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? AppTheme.nearlyBlue : AppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: AppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color:
                        isSelected ? AppTheme.nearlyWhite : AppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget getSearchBarUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 8.0, left: 18),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.75,
  //           height: 64,
  //           child: Padding(
  //             padding: const EdgeInsets.only(top: 8, bottom: 8),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: HexColor('#F8FAFB'),
  //                 borderRadius: const BorderRadius.only(
  //                   bottomRight: Radius.circular(13.0),
  //                   bottomLeft: Radius.circular(13.0),
  //                   topLeft: Radius.circular(13.0),
  //                   topRight: Radius.circular(13.0),
  //                 ),
  //               ),
  //               child: Row(
  //                 children: <Widget>[
  //                   Expanded(
  //                     child: Container(
  //                       padding: const EdgeInsets.only(left: 16, right: 16),
  //                       child: TextFormField(
  //                         style: TextStyle(
  //                           fontFamily: 'WorkSans',
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 16,
  //                           color: AppTheme.nearlyBlue,
  //                         ),
  //                         keyboardType: TextInputType.text,
  //                         decoration: InputDecoration(
  //                           labelText: 'Search for course',
  //                           border: InputBorder.none,
  //                           helperStyle: TextStyle(
  //                             fontWeight: FontWeight.normal,
  //                             fontSize: 16,
  //                             color: HexColor('#B9BABC'),
  //                           ),
  //                           labelStyle: TextStyle(
  //                             fontWeight: FontWeight.w600,
  //                             fontSize: 16,
  //                             letterSpacing: 0.2,
  //                             color: HexColor('#B9BABC'),
  //                           ),
  //                         ),
  //                         onEditingComplete: () {},
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: 60,
  //                     height: 60,
  //                     child: Icon(Icons.search, color: HexColor('#B9BABC')),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         const Expanded(
  //           child: SizedBox(),
  //         )
  //       ],
  //     ),
  //   );
  // }
  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: AppTheme.grey,
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.link, size: 30, color: AppTheme.lightText),
                      border: InputBorder.none,
                      hintText: ConstString.PRODUCT_URL,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: HexColor('#F8FAFB'),
          //     borderRadius: const BorderRadius.all(
          //       Radius.circular(38.0),
          //     ),
          //     boxShadow: <BoxShadow>[
          //       BoxShadow(
          //           color: Colors.grey.withOpacity(0.4),
          //           offset: const Offset(0, 2),
          //           blurRadius: 8.0),
          //     ],
          //   ),
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWell(
          //       borderRadius: const BorderRadius.all(
          //         Radius.circular(12.0),
          //       ),
          //       onTap: () {
          //         FocusScope.of(context).requestFocus(FocusNode());
          //       },
          //       child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: Icon(Icons.content_paste,
          //             size: 21, color: AppTheme.dismissibleBackground),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            child: Image.asset('assets/userImage.png'),
          )
        ],
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}
