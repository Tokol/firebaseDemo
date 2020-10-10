import 'package:firebasedemo/database/database.dart';
import 'package:firebasedemo/khata_model.dart';
import 'package:flutter/material.dart';

class KhataData extends ChangeNotifier {


  List<Khata> _khataList = [];

  Future<List<Khata>> getKhataList() async {
  var result =   await DB.query();
  if(result!=null){
    _khataList = result;
  }
  notifyListeners();
  return _khataList;

  }


  void insertKhata(Khata khata) async {
    await DB.insert(khata);
    notifyListeners();
    getKhataList();

  }





}