

import 'dart:io';

import 'package:flutter_employee_app/model/employee_master_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper.createInstance();


  factory DatabaseHelper(){
    if(_databaseHelper ==null) {
      _databaseHelper = DatabaseHelper.createInstance();
    }
    return _databaseHelper;
  }

   initializeDatabase() async{

    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path +'master.db';
    var masterDatabase  = await openDatabase(path,version: 1,onCreate: _createDb);
    return masterDatabase;
   }

  void _createDb(Database db, int newVersion) async{

      await db.execute(table);

  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  getMaster() async{
    Database db = await this.database;
  //  var result = await db.rawQuery("SELECT * FROM $TABLE_NAME ORDER BY $COLUMN_ID ASC");
   // var result1 = await db.execute("DROP TABLE IF EXISTS " + table);

    var result = await db.query(TABLE_NAME,orderBy:'$COLUMN_ID ASC');
    return result;
  }
  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(MasterList masterList) async {
    Database db = await this.database;
    var result = await db.insert(TABLE_NAME, masterList.toJson());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(MasterList masterList) async {
    var db = await this.database;
    var result = await db.update(TABLE_NAME, masterList.toJson(), where: '$COLUMN_ID = ?', whereArgs: [masterList.data]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $TABLE_NAME WHERE $COLUMN_ID = $id');
    return result;
  }

}