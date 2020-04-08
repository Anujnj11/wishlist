import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wishlisttracker/screen/homescreen.dart';
import 'package:wishlisttracker/screen/howToInfo.dart';
import 'package:wishlisttracker/screen/splashScreen.dart';
import 'package:wishlisttracker/screen/wishlistDetails.dart';

const String initialRoute = "/";

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/wishlist':
        return MaterialPageRoute(builder: (_) => WishlistDetails());
      // case '/howToInfo':
      //   return MaterialPageRoute(builder: (_) => HowToInfo());
      // case 'login':
      //   return MaterialPageRoute(builder: (_) => LoginView());
      // case 'post':
      //   var post = settings.arguments as Post;
      //   return MaterialPageRoute(builder: (_) => PostView(post: post));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
