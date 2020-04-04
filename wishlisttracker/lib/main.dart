import 'package:flutter/material.dart';
// import 'package:wishlisttracker/screen/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:wishlisttracker/models/wishlist.dart';
import './router.dart';
import 'package:wishlisttracker/models/searchBarUrl.dart';
import 'package:wishlisttracker/models/userInfo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInfo>(
          create: (context) => UserInfo(),
        ),
        ChangeNotifierProvider<SearchBarURL>(
          create: (context) => SearchBarURL(),
        ),
         ChangeNotifierProvider<Wishlist>(
          create: (context) => Wishlist(),
        ),
      ],
      child: MaterialApp(
        title: 'Wishlist Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF3EBACE),
          // accentColor: Color(0xFFD8ECF1),
          // accentColor: Colors.black, //Color(4281215567),
          accentColor: Color(4279046163),
          // scaffoldBackgroundColor: Color(4294440951),
          scaffoldBackgroundColor: Color(4294572538),


          // Use the old theme but apply the following three changes
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'BalooThambi2',
              bodyColor: Colors.black,
              displayColor: Colors.white),
        ),
        // home: HomeScreen(),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
