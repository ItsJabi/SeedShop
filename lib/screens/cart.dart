import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_signupforms/screens/modals/listSeed.dart';
import 'package:login_signupforms/screens/modals/seeds.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  void showseedDetails(index) {
    Seed s = listSeed.seed[index];
    Navigator.pushNamed(context, '/seeddetails', arguments: {
      'seedName': s.seedName,
      'seedImage': s.seedImage,
      'seedOG': s.seedOG,
      'availability': s.availability,
      'shopName': s.shopName,
    });
  }

  void detailsDesc(index) {
    Seed desc = listSeed.seed[index];
    Navigator.pushNamed(context, '/desc', arguments: {
      'flowerImage': desc.flowerImage,
      'description': desc.description
    });
  }

  getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('checkstatus', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#f8f9fc'),
      appBar: AppBar(
        backgroundColor: HexColor('#fadd00'),
        title: Text(
          'Cart',
          style: TextStyle(fontFamily: 'Antic'),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.home),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/wel');
          },
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/check');
            },
            icon: Icon(Icons.check_circle_outline),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: listSeed.seed.length,
          itemBuilder: (context, index) {
            return listSeed.seed[index].cart > 0
                ? Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                        child: Container(
                          padding: EdgeInsets.only(right: 2),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                  color: HexColor('#e2e2e2'),
                                  depth: 2,
                                  intensity: 1,
                                  lightSource: LightSource.topRight,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20))),
                              child: ListTile(
                                  onTap: () {
                                    showseedDetails(index);
                                  },
                                  title: Text(
                                    listSeed.seed[index].seedName,
                                    style: TextStyle(),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'images/${listSeed.seed[index].seedImage}'),
                                  ),
                                  subtitle: Text(
                                    listSeed.seed[index].seedOG +
                                        " " +
                                        "x${listSeed.seed[index].cart}",
                                    style: TextStyle(),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.info_outline),
                                        tooltip: 'See Description',
                                        color: Colors.blue,
                                        onPressed: () {
                                          detailsDesc(index);
                                        },
                                      ),
                                      IconButton(
                                          iconSize: 20,
                                          icon: Icon(Icons.add_circle,
                                              color: Colors.pink),
                                          onPressed: () {
                                            setState(() {
                                              listSeed.seed[index].cart =
                                                  listSeed.seed[index].cart + 1;
                                            });
                                          }),
                                      IconButton(
                                          iconSize: 20,
                                          icon: Icon(Icons.remove_circle,
                                              color: Colors.pink),
                                          onPressed: () {
                                            if (listSeed.seed[index].cart > 0) {
                                              setState(() {
                                                listSeed.seed[index].cart =
                                                    listSeed.seed[index].cart -
                                                        1;
                                              });
                                            }
                                          })
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
