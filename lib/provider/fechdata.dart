import 'package:flutter/cupertino.dart';

import '../database/database.dart';
import '../modal/ModelClass.dart';

class Fetchdata extends ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController note = TextEditingController();
  bool? isupdate;
  String? updateid;
  Addnote() async {
    Map<String, dynamic> row = {
      Databasehelper.columnname: name.text,
      Databasehelper.columnnote: note.text,
    };
    final id = await dbhelper.insert(row);
    getdata();
  }

  final dbhelper = Databasehelper.instance;
  List<dynamic> mydata = [];
  ModelClass? mylist;
  Future<dynamic> getdata() async {
    var dbClient = await dbhelper.database;
    final res = await dbClient.rawQuery("SELECT * FROM my_table");
    mydata = res;
    // mylist = ModelClass.fromJson(res!);
    notifyListeners();
    return mydata;
  }

  Updatedata() async {
    print("update data");
    var dbClient = await dbhelper.database;
    await dbClient.rawQuery(
        "UPDATE my_table SET name='${name.text}', note='${note.text}' WHERE id='$updateid'");
    // await dbClient.rawQuery(
    //     "UPDATE Test SET name = ?, note = ? WHERE id = ?' ['${name.text}', '${note.text}', '$updateid']");
    getdata();
  }

  deletedata(id) async {
    var dbClient = await dbhelper.database;
    await dbClient.rawQuery("DELETE FROM my_table WHERE id='$id'");
    getdata();
  }
}
