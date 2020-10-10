import 'package:firebasedemo/auth/sign_up_dart.dart';
import 'package:firebasedemo/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static final String id = "SPLASH_SCREEN";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  void checkUserLogin() async {
   try{
     SharedPreferences _pref = await SharedPreferences.getInstance();

     var isLogin = _pref.getBool("userLogin");

     print(isLogin);
     if (isLogin) {
       Navigator.pushReplacementNamed(context, HomePage.id);
     } else {
       Navigator.pushReplacementNamed(context, SignUpScreen.id);
     }
   }

   catch(e){
     Navigator.pushReplacementNamed(context, SignUpScreen.id);
   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.only(bottom: 60.0, left: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text('Write your Journal here....'),
          Text('Loading....'),
        ],
      ),
    ));
  }
}
