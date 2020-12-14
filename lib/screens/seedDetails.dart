import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';

class SeedDetails extends StatefulWidget {
  @override
  _SeedDetailsState createState() => _SeedDetailsState();
}

class _SeedDetailsState extends State<SeedDetails> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String seedimg = data['seedImage'];
    return Scaffold(
      backgroundColor: HexColor('#f8f9fc'),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Seeds Details', style: TextStyle(fontFamily: 'Antic')),
      ),
      body: SingleChildScrollView(
        child: TweenAnimationBuilder(
          builder: (BuildContext con, val, Widget c) {
            return Opacity(
              opacity: val,
              child: Padding(
                padding: EdgeInsets.only(top: val * 20),
                child: c,
              ),
            );
          },
          curve: Curves.easeIn,
          duration: Duration(seconds: 1),
          tween: Tween<double>(begin: 0, end: 1),
          child: Container(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.8),
                              spreadRadius: 5,
                              blurRadius: 5,
                              offset: Offset(5, 7))
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: AssetImage(
                          'images/$seedimg',
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: <Widget>[
                      NeumorphicText(
                        'Seed Name:  ',
                        style: NeumorphicStyle(
                            depth: 4,
                            intensity: 1,
                            lightSource: LightSource.bottomLeft,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        data['seedName'],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: <Widget>[
                      NeumorphicText(
                        'Seed Origin:  ',
                        style: NeumorphicStyle(
                            depth: 4,
                            intensity: 1,
                            lightSource: LightSource.bottomLeft,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        data['seedOG'],
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: <Widget>[
                      NeumorphicText(
                        'Seed Availability:  ',
                        style: NeumorphicStyle(
                            depth: 4,
                            intensity: 1,
                            lightSource: LightSource.bottomLeft,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(
                        width: 0.1,
                      ),
                      Text(
                        data['availability'],
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: <Widget>[
                      NeumorphicText(
                        'Shop Name:  ',
                        style: NeumorphicStyle(
                            depth: 4,
                            intensity: 1,
                            lightSource: LightSource.bottomLeft,
                            color: Colors.grey[700]),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        data['shopName'],
                        style: TextStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                NeumorphicButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                    style: NeumorphicStyle(
                        color: Colors.deepPurple,
                        depth: 4,
                        intensity: 1,
                        lightSource: LightSource.topLeft,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20))),
                    child: Text(
                      'View Cart',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(
                  height: 9,
                ),
                NeumorphicButton(
                    onPressed: () {
                      Navigator.pop(context, '/wel');
                    },
                    style: NeumorphicStyle(
                        color: Colors.deepPurple,
                        depth: 4,
                        intensity: 1,
                        lightSource: LightSource.topLeft,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20))),
                    child: Text(
                      'Back',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
