import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databasehelper {
  static final _databasename = "persons.db";
  static final _databaseversion = 1;
  static final table = "my_table";

  static final columnID = "id";
  static final columnname = "name";
  static final columnnote = "note";

  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int versoion) async {
    await db.execute('''
CREATE TABLE $table(
  $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnname TEXT NOT NULL,
  $columnnote TEXT NOT NULL
)
 ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

// final dbhelper = Databasehelper.instance;
//
// void insertdata() async{
//   Map<String,dynamic> row={
//     Databasehelper.columnName:"Amarjeet",
//     Databasehelper.columnage:20,
//   };
//   final id =await dbhelper.insert(row);
//
// }
}
