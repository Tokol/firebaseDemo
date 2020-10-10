import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/home_page.dart';
import 'package:firebasedemo/widget/firebase_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = "SIGNUP_SCREEN";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  String gender;
  String email;
  String password;
  String phone;
  String firstName;
  String lastName;
  bool loading = false;

  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Registration'),
      ),
      body: SingleChildScrollView(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(
                      'https://www.clipartkey.com/mpngs/m/29-297748_round-profile-image-placeholder.png'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: IconButton(
                    icon: Icon(Icons.image),
                    iconSize: 30.0,
                    color: Colors.cyan,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            FireBaseInput(
              hintValue: "Enter Email",
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
               email = value;
              },
            ),
            SizedBox(
              height: 10.0,
            ),


            Row(
              children: <Widget>[

                Expanded(

                  child: FireBaseInput(
                    hintValue: "First Name",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                     firstName = value;
                    },
                  ),
                ),

                Expanded( child: FireBaseInput(
                  hintValue: "Last Name",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    lastName = value;
                  },
                )),


              ],

            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

              child: DropdownButtonHideUnderline(

                child: DropdownButton(

                    hint: Text('Select Gender'),

                      isExpanded: true,
                    onChanged: (value){
                       setState(() {
                         gender = value;
                         print(gender);
                       });

                    },
                  items: [

                    DropdownMenuItem(
                      child: Text('male'),
                      value: "Male",

                    ),

                    DropdownMenuItem(
                      child: Text('Female'),
                      value: "Female",

                    ),




                    DropdownMenuItem(
                      child: Text('Others'),
                      value: "Others",

                    ),



                  ],

                ),
              ),
            ),


            SizedBox(
              height: 10.0,
            ),


            FireBaseInput(
              hintValue: "Contact Number ",
              keyboardType: TextInputType.phone,
              obscureText: true,
              onChanged: (value) {
                phone = value;
              },
            ),

            SizedBox(
              height: 10.0,
            ),

            FireBaseInput(
              hintValue: "Password ",
              obscureText: true,
              onChanged: (value) {
              password = value;
              },
            ),

            SizedBox(
              height: 20.0,
            ),


          loading?CircularProgressIndicator():
          RaisedButton(
            onPressed: ()async{
              setState(() {
                loading=true;
              });

              try{
                var result =   await auth.createUserWithEmailAndPassword(email: email, password: password);
                if(result.additionalUserInfo.isNewUser){
                  SharedPreferences  _pref = await SharedPreferences.getInstance();
                  _pref.setBool("userLogin",true);
                  Navigator.pushReplacementNamed(context, HomePage.id);
                }

                else{

                }

              }

              catch(e){
                  print(e.toString());

              }





              setState(() {
                loading=false;
              });
              
            },
            color: Colors.redAccent,
            highlightColor: Colors.greenAccent,
            child: Container(
                padding: EdgeInsets.all(20.0),

                width: MediaQuery.of(context).size.width-100,
                child: Center(
                    child: Text('Register', style: TextStyle(color: Colors.white),))),
          ),



          ],
        ),
      ),
    );
  }
}
