import 'package:flutter/material.dart';
import 'package:login_signupforms/screens/cart.dart';
import 'package:login_signupforms/screens/checkout.dart';
import 'package:login_signupforms/screens/description.dart';
import 'package:login_signupforms/screens/login.dart';
import 'package:login_signupforms/screens/seedDetails.dart';
import 'package:login_signupforms/screens/sigup.dart';
import 'package:login_signupforms/screens/splash.dart';
import 'package:login_signupforms/screens/home.dart';
import 'package:login_signupforms/screens/wishlist.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => Splash(),
        '/login': (context) => LoginForm(),
        '/signup': (context) => SignupForm(),
        '/wel': (context) => HomeScaf(),
        '/cart': (context) => Cart(),
        '/seeddetails': (context) => SeedDetails(),
        WishList.routeName: (context) => WishList(),
        '/desc': (context) => Description(),
        '/check': (context) => Checkout(),
      },
    ));
