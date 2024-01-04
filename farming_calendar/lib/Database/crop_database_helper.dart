import 'package:sqflite/sqflite.dart';

import '../Crop/crop.dart';

class DbHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "crops";

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'crops.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creating");
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "plant STRING, duration INTEGER, color INTEGER, "
            "startDate STRING, endDate STRING)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Crop? crop) async {
    print("insert function called");
    return await _db?.insert(_tableName, crop!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

  static delete(Crop crop) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [crop.id]);
  }
}
