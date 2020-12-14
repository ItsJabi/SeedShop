import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  static const routeName = "/login-screen";
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final scaffkey = GlobalKey<ScaffoldState>();

  String saveEmail = '';
  String savePass = '';
  String username = '';
  bool checkboxvalue = false;

  Future check() async {
    if (saveEmail != null && savePass != null) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      saveEmail = pref.getString('saveEmail');
      savePass = pref.getString('savePass');
      if (pref.getBool('checkstatus') != null) {
        checkboxvalue = pref.getBool('checkstatus');
      }
      username = pref.getString('Username');
      print("Email: $saveEmail");
      print("Password: $savePass");
      print('Check: $checkboxvalue');
      print('username: $username');
    }
  }

  getCheckedval(bool accept) async {
    print("abc");
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('checkstatus', accept);
  }

  void validator() {
    if (_formkey.currentState.validate()) {
      print('validated');
    } else {
      print('not validated');
    }
  }

  @override
  void initState() {
    super.initState();
    check();
  } // and call this function to confirm

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#eff3f6'),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 40),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formkey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Center(
                    child: Image(
                      height: 200,
                      width: 200,
                      image: AssetImage('images/tree2.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                        depth: 2,
                        intensity: 1,
                        lightSource: LightSource.bottomRight,
                        surfaceIntensity: 1),
                    child: TextFormField(
                      validator: (String val) {
                        if (val.length == 0) {
                          return 'Email is required';
                        } else if (val != saveEmail) {
                          return 'not valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Email',
                          icon: Icon(
                            Icons.mail,
                            color: Colors.green,
                          ),
                          hintText: 'abc@gmail.com',
                          labelStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20)),
                      depth: 2,
                      intensity: 1,
                      lightSource: LightSource.bottomRight,
                      surfaceIntensity: 1,
                    ),
                    child: TextFormField(
                      validator: (String val) {
                        if (val.length == 0) {
                          return 'password is required';
                        } else if (val != savePass) {
                          return 'not valid password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key_sharp, color: Colors.green),
                        labelText: 'Password',
                        hintText: '********',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      obscureText: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      NeumorphicCheckbox(
                        style: NeumorphicCheckboxStyle(
                            selectedColor: Colors.green,
                            lightSource: LightSource.bottomLeft),
                        value: checkboxvalue,
                        onChanged: (value) {
                          setState(() {
                            this.checkboxvalue = value;
                          });
                        },
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        child: NeumorphicText(
                          'Remember me',
                          style: NeumorphicStyle(
                            color: Colors.grey[600],
                            lightSource: LightSource.bottomLeft,
                            depth: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                NeumorphicButton(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  margin: EdgeInsets.only(left: 30, right: 20),
                  style: NeumorphicStyle(
                      color: Colors.green,
                      depth: 4,
                      intensity: 1,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20)),
                      lightSource: LightSource.topLeft),
                  onPressed: () {
                    setState(() {
                      validator();
                      check();
                      getCheckedval(checkboxvalue);
                      if (_formkey.currentState.validate()) {
                        final snack = SnackBar(
                          backgroundColor: Colors.white,
                          content: SnackBarAction(
                            onPressed: () {},
                            label: 'Logged in successfully',
                            textColor: Colors.green,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                        Navigator.pushNamed(context, '/wel');
                      } else if (!_formkey.currentState.validate()) {
                        final snack = SnackBar(
                          backgroundColor: Colors.white,
                          content: SnackBarAction(
                            onPressed: () {},
                            label: 'Invalid ',
                            textColor: Colors.green,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);
                      } else {
                        return 'something went wrong';
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 60, right: 50),
                    height: 30,
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        NeumorphicText(
                          'Dont have an account?',
                          style: NeumorphicStyle(
                            color: Colors.grey,
                            lightSource: LightSource.bottomLeft,
                            depth: 4,
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        InkWell(
                          child: Text(
                            'SignUp',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            setState(() {
                              Navigator.pushNamed(context, '/signup');
                            });
                          },
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
