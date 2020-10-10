import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/datas/KhataData.dart';
import 'package:firebasedemo/khata_model.dart';
import 'package:firebasedemo/widget/firebase_input.dart';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'database/database.dart';

class HomePage extends StatefulWidget {
  static final String id = "HOME_SCREEN";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getListOfKhata();
    super.initState();
  }

  void getListOfKhata() async {
    await DB.query();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<KhataData>(
      builder: (context, data, child) {
        return FutureBuilder<List<Khata>>(

          future: data.getKhataList(),

          builder: (BuildContext context, AsyncSnapshot<List<Khata>> snapshot) {

            if (snapshot.hasData) {
              if(snapshot.data.length>0){

                return GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Scaffold(
                      appBar: AppBar(
                        title: Text('Home'),
                        actions: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Khata _khata = Khata();

                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    DateTime now = DateTime.now();
                                    DateFormat formatter =
                                    DateFormat('yyyy-MM-dd');
                                    _khata.date =
                                        (formatter.format(now)).toString();

                                    return StatefulBuilder(
                                      builder: (context, state) {
                                        return Container(
                                          height:
                                          MediaQuery.of(context).size.height -
                                              150,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: 15.0),
                                                    child: Text(
                                                      'Save Khata Detail',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    )),
                                                FireBaseInput(
                                                  hintValue: 'Name',
                                                  onChanged: (value) {
                                                    _khata.name = value;
                                                  },
                                                ),
                                                FireBaseInput(
                                                  hintValue: 'Item Name',
                                                  onChanged: (value) {
                                                    _khata.itemName = value;
                                                  },
                                                ),
                                                FireBaseInput(
                                                  hintValue: 'Rate',
                                                  onChanged: (value) {
                                                    _khata.rate = value;
                                                  },
                                                ),
                                                FireBaseInput(
                                                  hintValue: 'Quantity',
                                                  onChanged: (value) {
                                                    _khata.quantity = value;
                                                  },
                                                ),
                                                FireBaseInput(
                                                  hintValue: 'Contact',
                                                  onChanged: (value) {
                                                    _khata.contact = value;
                                                  },
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    DatePicker.showDatePicker(
                                                        context,
                                                        showTitleActions: true,
                                                        minTime:
                                                        DateTime(1990, 3, 5),
                                                        maxTime: DateTime.now(),
                                                        onChanged: (date) {
                                                          DateFormat formatter =
                                                          DateFormat(
                                                              'yyyy-MM-dd');
                                                          state(() {
                                                            _khata.date = (formatter
                                                                .format(date))
                                                                .toString();
                                                          });
                                                        }, onConfirm: (date) {
                                                      DateFormat formatter =
                                                      DateFormat(
                                                          'yyyy-MM-dd');
                                                      state(() {
                                                        _khata.date = (formatter
                                                            .format(date))
                                                            .toString();
                                                      });
                                                    },
                                                        currentTime:
                                                        DateTime.now(),
                                                        locale: LocaleType.en);
                                                  },
                                                  child: Container(
                                                      padding:
                                                      EdgeInsets.all(20.0),
                                                      margin:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                        border: Border.all(
                                                            width: 1.0,
                                                            color:
                                                            Colors.black38),
                                                      ),
                                                      child: Text(
                                                        _khata.date,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                            FontWeight.w600),
                                                      )),
                                                ),
                                                FireBaseInput(
                                                  hintValue: 'Remark',
                                                  onChanged: (value) {
                                                    _khata.remarks = value;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom ==
                                                      0
                                                      ? 10
                                                      : 300,
                                                ),
                                                RaisedButton(
                                                  highlightColor:
                                                  Colors.amberAccent,
                                                  color: Colors.greenAccent,
                                                  elevation: 10.0,
                                                  child: Container(
                                                      padding:
                                                      EdgeInsets.all(20.0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
                                                      width:
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          2,
                                                      child: Text(
                                                        'Save',
                                                        textAlign:
                                                        TextAlign.center,
                                                      )),
                                                  onPressed: () {
                                                    data.insertKhata(_khata);

                                                    Navigator.pop(context);
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  });
                            },
                          )
                        ],
                      ),
                      body: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, position) {
                            return Padding(
                              padding: EdgeInsets.all(10.0),

                              child: Card(
                                elevation: 10,
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[

                                          IconButton(icon: Icon(Icons.edit),onPressed: (){},),
                                          IconButton(icon: Icon(Icons.delete), onPressed: (){},),



                                        ],
                                      ),
                                      Text((snapshot.data[position].name).toString(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                                      Text((snapshot.data[position].itemName).toString()),
                                      Text((snapshot.data[position].rate).toString()),
                                      Text((snapshot.data[position].quantity).toString()),

                                      //Text("Total: ${(snapshot.data[position].rate) * int.parse(snapshot.data[position].quantity)}"),

                                      Text((snapshot.data[position].date).toString()),
                                      Text((snapshot.data[position].remarks).toString()),


                                      Text((snapshot.data[position].contact).toString()),





                                    ],
                                  ),

                                ),
                              ),
                            );
                          })),
                );

              }

              else{
                return Container(
                  child: Text('Khata List is Empty'),
                );
              }
            }


            else{
              return Container(
                child: Text('No data found'),
              );
            }

          },
        );
      },
    );
  }
}
