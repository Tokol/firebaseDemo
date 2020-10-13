import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'chat_model.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  String textValue = "";
  String currentUserEmail  = "test@gmail.com";
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    getUserEmail();
   
    super.initState();
  }

  void getUserEmail() async {
  //  currentUserEmail =

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection("khatarequest").snapshots(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return Container();
                }

                else{
                  final messages = snapshot.data.docs.reversed.toList();

                  List<ChatModel> _chatModels = [];

                  for(int i=0; i<messages.length; i++){
                  var res = messages[i].data();

                  String email = res ["email"];
                  String message = res["message"];

                  _chatModels.add(ChatModel(
                    email: email,
                    message: message,
                  ));

                  }


                  return ListView.builder(
                    reverse: true,
                      itemCount: _chatModels.length,
                      itemBuilder: (context,position){

                        return Container(

                            decoration:BoxDecoration(
                              color: _chatModels[position].email == currentUserEmail? Colors.lightBlue:Colors.white70,

                            ),
                          child: Column(
                            children: <Widget>[
                              Text(_chatModels[position].email),
                              Text(_chatModels[position].message),

                            ],
                          ),



                        );

                      });


                }
              },
              
              
              
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                suffixIcon: textValue.length > 1
                    ? IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          
                          _fireStore.collection("khatarequest").add({
                            "email": "test11@gmail.com",
                            "message": textValue
                          });
                          controller.clear();
                          textValue = "";
                        },
                      )
                    : SizedBox(width: 0),
                contentPadding: EdgeInsets.all(20.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                      width: 0.6,
                      color: Colors.black38,
                    )),
                filled: true,
                fillColor: Colors.white,
              ),
              autocorrect: false,
              textCapitalization: TextCapitalization.none,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  textValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
