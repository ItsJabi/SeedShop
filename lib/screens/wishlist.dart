import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_signupforms/screens/modals/listSeed.dart';
import 'package:login_signupforms/screens/modals/seeds.dart';

import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  static const routeName = "/wishlist";
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  Map data = {};
  List<bool> _selection;
  String username = '';
  getun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('Username');
    });
    print(username);
  }

  List<Seed> _cart = List<Seed>();

  @override
  void initState() {
    super.initState();
    _selection = List.generate(listSeed.seed.length, (index) => false);
    getun();
  }

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
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          SafeArea(
            child: DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/flowers.jpg'), fit: BoxFit.cover),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.verified_user, color: Colors.blue),
                title: Text('Welcome: $username'),
              ),
              ListTile(
                leading: Icon(
                  Icons.home_outlined,
                  color: Colors.green,
                ),
                title: Text('HomePage'),
                onTap: () {
                  Navigator.pushNamed(context, '/wel');
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite, color: Colors.red),
                title: Text('WishList'),
                onTap: () {
                  Navigator.pushNamed(context, WishList.routeName);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.yellow,
                ),
                title: Text('Logout'),
                onTap: () {
                  getUser();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ],
      )),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text(
          'WishList',
          style: TextStyle(fontFamily: 'Antic'),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart');
              },
              tooltip: 'View Cart',
              icon: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: listSeed.seed.length,
          itemBuilder: (context, index) {
            return listSeed.seed[index].fav
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
                                    listSeed.seed[index].seedOG,
                                    style: TextStyle(),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      listSeed.seed[index].fav
                                          ? IconButton(
                                              tooltip: 'Remove',
                                              iconSize: 20,
                                              icon: Icon(Icons.delete,
                                                  color: Colors.red),
                                              onPressed: () {
                                                setState(() {
                                                  if (listSeed
                                                          .seed[index].fav ==
                                                      false) {
                                                    listSeed.seed[index].fav =
                                                        true;
                                                  } else {
                                                    listSeed.seed[index].fav =
                                                        false;
                                                  }
                                                  _selection[index] =
                                                      !_selection[index];
                                                });
                                              })
                                          : Text('nothing to delete'),
                                      IconButton(
                                        icon: Icon(Icons.info_outline),
                                        color: Colors.blue,
                                        tooltip: 'See Description',
                                        onPressed: () {
                                          detailsDesc(index);
                                        },
                                      ),
                                      IconButton(
                                        iconSize: 20,
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/wel');
                                        },
                                        icon: Icon(Icons.home),
                                        color: Colors.green[400],
                                        tooltip: 'Go to HomeScreen',
                                      ),
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
