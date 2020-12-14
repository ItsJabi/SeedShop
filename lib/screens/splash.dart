import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool checkboxvalue = pref.getBool('checkstatus');
    print("please check");
    print(checkboxvalue);
    if (checkboxvalue == true) {
      Navigator.pushNamed(context, '/wel');
    } else {
      Navigator.popAndPushNamed(context, '/login');
    }
  }

  double opa = 0.0;
  changeOpa() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        opa = opa == 0.0 ? 1.0 : 0.0;
      });
    });
  }

  @override
  void initState() {
    changeOpa();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      //Navigator.popAndPushNamed(context, '/login');
      getUser();
    });
    return Scaffold(
      backgroundColor: HexColor('#eff3f6'),
      body: AnimatedOpacity(
          opacity: opa,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 150),
              child: Center(
                child: Column(children: <Widget>[
                  Image(
                    image: AssetImage('images/tree2.png'),
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 25),
                  ),
                ]),
              ),
            ),
          ),
          duration: Duration(seconds: 1)),
    );
  }
}
