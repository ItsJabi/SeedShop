import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:login_signupforms/screens/modals/listSeed.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

List flowerimg = [];

class _DescriptionState extends State<Description> {
  Map data = {};
  String description = "";

  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context).settings.arguments;
    description = listSeed.seed[index].description;
    flowerimg = listSeed.seed[index].flowerImage;
    print(flowerimg);
    List<Widget> imageSliders = flowerimg
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(item, fit: BoxFit.cover, width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${(flowerimg.indexOf(item)) + 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
    return Scaffold(
      backgroundColor: HexColor('#f8f9fc'),
      appBar: AppBar(
          backgroundColor: Colors.brown,
          centerTitle: true,
          title: Text('Description', style: TextStyle(fontFamily: 'Antic'))),
      body: SingleChildScrollView(
        child: TweenAnimationBuilder(
          builder: (BuildContext context, val, Widget c) {
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
            padding: EdgeInsets.only(left: 5, right: 5, top: 8),
            child: Column(
              children: <Widget>[
                // CarouselSlider(items: [
                //   Container(
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(20),
                //         image: DecorationImage(
                //             image: NetworkImage('${flowerimg[0]}'),
                //             fit: BoxFit.cover)),
                //   )
                // ], options: CarouselOptions(height: 300)),
                Container(
                    child: Column(
                  children: <Widget>[
                    CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                      ),
                      items: imageSliders,
                    ),
                  ],
                )),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    NeumorphicText(
                      'Details Description:',
                      style: NeumorphicStyle(
                          depth: 4,
                          intensity: 1,
                          lightSource: LightSource.bottomLeft,
                          color: Colors.grey[600]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(letterSpacing: 0.8),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
