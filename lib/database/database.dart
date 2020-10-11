import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../khata_model.dart';

class DB {
  static Database _db;

  static String KHATA_TABLE = "Khata";
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    } else {
      try {
        String _path = await getDatabasesPath() + "khataPath";
        _db = await openDatabase(_path, version: _version, onCreate: onCreate);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static void onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $KHATA_TABLE ("
        "id INTEGER PRIMARY KEY,"
        "name TEXT,"
        "itemName TEXT,"
        "quantity TEXT,"
        "rate INTEGER,"
        "date TEXT,"
        "contact TEXT,"
        "remarks TEXT"
        ")");
  }

  static Future<int> insert(Khata khata) async {
    var table = await _db.rawQuery("SELECT MAX(id)+1 as id FROM $KHATA_TABLE");
    int id = table.first["id"];
    var raw = await _db.rawInsert(
        "INSERT INTO $KHATA_TABLE (id, name, itemName, quantity, rate, date, contact, remarks)"
        "VALUES (?,?,?,?,?,?,?,?)",
        [
          id,
          khata.name,
          khata.itemName,
          khata.quantity,
          khata.rate,
          khata.date,
          khata.contact,
          khata.remarks
        ]);
    return raw;
  }

  static Future<List<Khata>> query() async {
    var res = await _db.query("${KHATA_TABLE}");

    List<Khata> khataList = [];

    if (res.isNotEmpty) {
      for (int i = 0; i < res.length; i++) {
        int id = res[i]["id"];
        String name = res[i]["name"];
        String itemName = res[i]["itemName"];

        String quantity = res[i]["quantity"];
        int rate = res[i]["rate"];
        String date = res[i]["date"];

        String contact = res[i]["contact"];
        String remarks = res[i]["remarks"];

        khataList.add(Khata(
            id: id,
            name: name,
            itemName: itemName,
            quantity: quantity,
            rate: rate,
            date: date,
            contact: contact,
            remarks: remarks));
      }

      return khataList;
    } else {
      return null;
    }
  }


  static Future<int> update(Khata khata) async {
    await _db.update("$KHATA_TABLE", khata.toMap(), where: 'id=?', whereArgs: [khata.id]);
  }


  static Future<int> delete(Khata khata) async{
    await _db.delete("$KHATA_TABLE",  where: 'id=?', whereArgs: [khata.id]);
  }




}
