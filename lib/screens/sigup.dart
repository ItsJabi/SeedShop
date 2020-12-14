import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:login_signupforms/screens/login.dart';
import 'package:login_signupforms/screens/modals/stat.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hexcolor/hexcolor.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController pass = TextEditingController();
  TextEditingController conpass = TextEditingController();
  TextEditingController confemail = TextEditingController();
  TextEditingController usern = TextEditingController();

  void validator() {
    if (formkey.currentState.validate()) {
      print('validated');
    } else {
      print('not validated');
    }
  }

  saveData(String email, String password, String username) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('saveEmail', email);
    pref.setString('savePass', password);
    pref.setString('Username', username);
  }

  String checkmail = '';
  String checkusername = '';
  checkUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    checkmail = pref.getString('saveEmail');
    checkusername = pref.getString('Username');
    print('mail:$checkmail');
    print('username:$checkusername');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   saveData(confemail.text.toString(), conpass.text.toString(),
  //       usern.text.toString());
  //   checkUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#eff3f6'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 50),
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Center(
                    child: Image(
                      image: AssetImage('images/tree2.png'),
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),
                Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        depth: 2,
                        intensity: 1,
                        lightSource: LightSource.bottomRight,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20))),
                    child: TextFormField(
                      controller: usern,
                      validator: (val) {
                        if (val.length == 0) {
                          return 'Username is required';
                        } else if (val.length > 10) {
                          return 'Username should be less than 10 characters';
                        } else if (val.trim() == checkusername) {
                          return 'Username is already in use';
                        }
                        formkey.currentState.save();
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Username',
                        hintText: 'What do we call you?',
                        icon: Icon(
                          Icons.person,
                          color: Colors.green,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onSaved: (val) => Stat.username = val,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                        depth: 2,
                        lightSource: LightSource.bottomRight,
                        intensity: 1),
                    child: TextFormField(
                      controller: confemail,
                      validator: (val) {
                        if (val.length == 0) {
                          return 'Please enter an email adress';
                        } else if (!val.contains(
                          '@',
                        )) {
                          return 'Not a valid email address';
                        } else if (val.trim() == checkmail) {
                          return 'Email aready registered';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Email',
                        hintText: 'abc@gmail.com',
                        icon: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onSaved: (val) => Stat.email = val,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                        depth: 2,
                        intensity: 1,
                        lightSource: LightSource.bottomRight),
                    child: TextFormField(
                      controller: pass,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Please provide a password';
                        } else if (pass.text.length < 8) {
                          return 'password should be at least of 8 characters';
                        } else if (pass.text.length > 15) {
                          return 'password should be of 15 characters';
                        }
                        formkey.currentState.save();
                        return null;
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        icon: Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.green,
                        ),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      obscureText: true,
                      onSaved: (val) => Stat.password = val,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  child: Neumorphic(
                    style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                        depth: 2,
                        intensity: 1,
                        lightSource: LightSource.bottomRight),
                    child: TextFormField(
                      controller: conpass,
                      validator: (String val) {
                        if (val.isEmpty) {
                          return 'Please re-enter password';
                        }
                        if (pass.text != conpass.text) {
                          return 'Password does not match';
                        }
                        formkey.currentState.save();
                        return null;
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Confirm Password',
                          icon: Icon(
                            Icons.vpn_key_sharp,
                            color: Colors.green,
                          ),
                          labelStyle: TextStyle(color: Colors.black)),
                      obscureText: true,
                      onSaved: (val) => Stat.conp = val,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.only(left: 50, right: 50),
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                        color: Colors.green,
                        depth: 4,
                        intensity: 1,
                        lightSource: LightSource.topLeft,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20))),
                    onPressed: () {
                      setState(() {
                        saveData(
                            confemail.text.toString().trim(),
                            conpass.text.toString().trim(),
                            usern.text.toString().trim());
                        validator();
                        checkUser();
                        if (formkey.currentState.validate()) {
                          formkey.currentState.save();
                          final snack = SnackBar(
                            backgroundColor: Colors.white,
                            content: SnackBarAction(
                              onPressed: () {},
                              label: 'Registration Successful',
                              textColor: Colors.green,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snack);
                          confemail.text = "";
                          conpass.text = '';
                          pass.text = '';
                          usern.text = '';
                        }
                        if (!formkey.currentState.validate()) {
                          formkey.currentState.save();
                          final snacks = SnackBar(
                            backgroundColor: Colors.white,
                            content: SnackBarAction(
                              onPressed: () {},
                              label: 'Registration Unsuccessful',
                              textColor: Colors.green,
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snacks);
                        }
                      });
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 1),
                      child: NeumorphicText(
                        'Already have an account?',
                        style: NeumorphicStyle(
                          color: Colors.grey,
                          lightSource: LightSource.bottomLeft,
                          depth: 4,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.popAndPushNamed(context, '/login');
                        });
                      },
                      child: Text(
                        'Login In',
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
