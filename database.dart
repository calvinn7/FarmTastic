// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
//import 'package:intl/intl.dart';

class DatabaseService {
  static DatabaseService instance = DatabaseService._privateConstructor();
  Database? _database;

  DatabaseService._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    final String path =
        join(await getDatabasesPath(), 'carbon_emissions_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
      singleInstance: true,
    );
  }


  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE carbon_emissions (
        id INTEGER PRIMARY KEY,
        emissions REAL,
        currentDate TEXT, 
        selectedDate TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE selected_date_emissions_records (
        id INTEGER PRIMARY KEY,
        emissions REAL,
        selectedDate TEXT
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> getEmissions() async {
    final Database db = await database;
    return await db.query(
      'carbon_emissions',
      orderBy: 'currentDate DESC',
    );
  }

  Future<List<Map<String, Object?>>> getSelectedDateEmissions(
      DateTime selectedDate) async {
    final Database db = await database;
    final formattedDate =
        selectedDate.toIso8601String(); // Format the date as needed

    return await db.query(
      'selected_date_emissions_records',
      where:
          'selectedDate = ?', // Add a WHERE clause to filter by selected date
      whereArgs: [formattedDate],
      orderBy: 'selectedDate DESC', // Change the column and order as needed
    );
  }

  Future<List<Map<String, Object?>>> getAllDates() async {
    final Database db = await database;

    return await db.query(
      'selected_date_emissions_records',
      columns: ['selectedDate'],
      groupBy: 'selectedDate',
      orderBy: 'selectedDate ASC',
    );
  }

  Future<void> deleteEmission(int id) async {
    await _database?.delete(
      'carbon_emissions',
      where: 'id = ?',
      whereArgs: [id],
    );
    
  }

  Future<void> deleteSelectedDateEmission(int id) async {
    final Database db = await database;
    await db.delete(
      'selected_date_emissions_records',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  void insertEmissions(
      double emissions, DateTime currentDate, DateTime selectedDate) async {
    final Database db = await database;
    await db.insert(
      'carbon_emissions',
      {
        'emissions': emissions,
        'currentDate': currentDate.toIso8601String(),
        'selectedDate': selectedDate.toUtc().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertSelectedDateEmissions(
      double emissions, DateTime selectedDate) async {
    final Database db = await database;
    await db.insert(
      'selected_date_emissions_records',
      {
        'emissions': emissions,
        'selectedDate': selectedDate.toUtc().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
