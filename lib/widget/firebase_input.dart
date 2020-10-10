import 'package:flutter/material.dart';

class FireBaseInput extends StatelessWidget {
  final String hintValue;
  final Function onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  FireBaseInput({this.hintValue="",this.onChanged,this.obscureText=false, this.keyboardType=TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: TextField(

        decoration: InputDecoration(


          hintText: hintValue,
          labelText: hintValue,
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.all(20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(width: 0.6, color: Colors.black38, )

          ),

          filled: true,
          fillColor: Colors.white,


        ),
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: keyboardType,
        obscureText: obscureText,
        onChanged: onChanged,

      ),
    );
  }
}
