import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_signupforms/screens/modals/listSeed.dart';
import 'package:login_signupforms/screens/modals/seeds.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
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

  void trackid(ind) {
    Seed tr = listSeed.seed[ind];

    Navigator.pushNamed(context, '/track', arguments: {'trackId': tr.trackId});
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
  void initState() {
    listSeed.seed = List.from(listSeed.seed);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#f8f9fc'),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/cart');
          },
        ),
        backgroundColor: Colors.orange,
        title: Text(
          'Checkout',
          style: TextStyle(fontFamily: 'Antic'),
        ),
        centerTitle: true,
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
                                    BorderRadius.circular(20)),
                              ),
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
                                        ' ' +
                                        'x${listSeed.seed[index].cart}',
                                    style: TextStyle(),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.info_outline),
                                        color: Colors.blue,
                                        tooltip: 'See Description',
                                        onPressed: () {
                                          detailsDesc(index);
                                        },
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (listSeed.seed[index].cart ==
                                              listSeed.seed[index].cart) {
                                            setState(() {
                                              listSeed.seed[index].cart = 0;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.delete),
                                        color: Colors.red,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Container();
          },
        ),
      ),
    );
  }
}
