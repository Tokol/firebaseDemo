import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedemo/datas/KhataData.dart';
import 'package:firebasedemo/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/sign_up_dart.dart';
import 'auth/splash_Screen.dart';
import 'database/database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.init();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<KhataData>(
      create: (context)=>KhataData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,

        theme: ThemeData(
          primaryColor: Color(0xffFBE4D4),
          backgroundColor: Colors.grey[200],

        ),

        initialRoute: SplashScreen.id,
        routes: {
          SignUpScreen.id:(context)=>SignUpScreen(),
          HomePage.id:(context)=>HomePage(),
          SplashScreen.id: (context)=>SplashScreen(),

        },

      ),
    );
  }
}



