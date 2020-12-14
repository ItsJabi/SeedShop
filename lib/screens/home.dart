import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:login_signupforms/screens/modals/listSeed.dart';
import 'package:login_signupforms/screens/modals/seeds.dart';

import 'package:login_signupforms/screens/wishlist.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MaterialApp(home: HomeScaf()));

class HomeScaf extends StatefulWidget {
  @override
  _HomeScafState createState() => _HomeScafState();
}

class _HomeScafState extends State<HomeScaf> {
  List<bool> _selection;

  String username = '';
  getun() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('Username');
    });
    print(username);
  }

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
    print(index);
    print(desc.flowerImage);
    Navigator.pushNamed(context, '/desc', arguments: index);
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
        backgroundColor: HexColor('#0d8e32'),
        title: Text(
          'Seeds List',
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
        child: AnimationLimiter(
          child: ListView.builder(
              itemCount: listSeed.seed.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(seconds: 1),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1, horizontal: 5),
                            child: Container(
                              padding: EdgeInsets.only(right: 2),
                              child: Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
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
                                                    tooltip:
                                                        'Remove from wishlist',
                                                    iconSize: 20,
                                                    icon: Icon(Icons.favorite,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (listSeed.seed[index]
                                                                .fav ==
                                                            false) {
                                                          listSeed.seed[index]
                                                              .fav = true;
                                                        } else {
                                                          listSeed.seed[index]
                                                              .fav = false;
                                                        }
                                                        _selection[index] =
                                                            !_selection[index];
                                                      });
                                                    })
                                                : IconButton(
                                                    tooltip: 'Add to WishList',
                                                    iconSize: 20,
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: Colors.grey[50],
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (listSeed.seed[index]
                                                                .fav ==
                                                            false) {
                                                          listSeed.seed[index]
                                                              .fav = true;
                                                        } else {
                                                          listSeed.seed[index]
                                                              .fav = false;
                                                        }
                                                        _selection[index] =
                                                            !_selection[index];
                                                      });
                                                    }),
                                            IconButton(
                                              color: Colors.blue,
                                              icon: Icon(Icons.info_outline),
                                              tooltip: 'See Description',
                                              onPressed: () {
                                                detailsDesc(index);
                                              },
                                            ),
                                            listSeed.seed[index].cart == 0
                                                ? IconButton(
                                                    iconSize: 20,
                                                    onPressed: () {
                                                      if (listSeed.seed[index]
                                                              .cart ==
                                                          0) {
                                                        setState(() {
                                                          listSeed.seed[index]
                                                              .cart = listSeed
                                                                  .seed[index]
                                                                  .cart +
                                                              1;
                                                        });
                                                        final snack = SnackBar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          content:
                                                              SnackBarAction(
                                                            onPressed: () {},
                                                            label: 'Item Added',
                                                            textColor:
                                                                Colors.green,
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snack);
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .add_shopping_cart),
                                                    tooltip: 'Add to cart',
                                                    color: Colors.grey,
                                                  )
                                                : IconButton(
                                                    iconSize: 20,
                                                    onPressed: () {
                                                      if (listSeed.seed[index]
                                                              .cart ==
                                                          1) {
                                                        setState(() {
                                                          listSeed.seed[index]
                                                              .cart = listSeed
                                                                  .seed[index]
                                                                  .cart +
                                                              0;
                                                        });
                                                        final snack = SnackBar(
                                                          backgroundColor:
                                                              Colors.white,
                                                          content:
                                                              SnackBarAction(
                                                            onPressed: () {},
                                                            label:
                                                                'Item Already Added',
                                                            textColor:
                                                                Colors.green,
                                                          ),
                                                        );
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snack);
                                                      }
                                                    },
                                                    icon: Icon(Icons
                                                        .add_shopping_cart),
                                                    tooltip: 'Add to cart',
                                                    color: HexColor('#0d8e32'),
                                                  )
                                          ],
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
