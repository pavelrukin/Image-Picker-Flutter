import 'dart:io';

import 'package:flutter_test_image_picker/model/DataResponse.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();


  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'dataresponse_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute('CREATE TABLE DataResponse('
              'iddd integer primary key AUTOINCREMENT,'
              'description TEXT,'
              'alt_description TEXT,'
              'urls TEXT,'
              'user TEXT'
              ')');
        });
  }
  // Insert employee on database
  createDataResponse(DataResponse dataResponse) async {
    await deleteAllDataResponse();
    final db = await database;
    final res = await db.insert('DataResponse', dataResponse.toMap());

    return res;
  }
  Future<int> deleteAllDataResponse() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM DataResponse');

    return res;
  }
  Future<List<DataResponse>> getAllDataResponse() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM DataResponse");

    List<DataResponse> list =
    res.isNotEmpty ? res.map((c) => DataResponse.fromJson(c)).toList() : [];

    return list;
  }
}