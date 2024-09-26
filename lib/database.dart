import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";

///   Crud
///
///
///
// Get a location using getDatabasesPath
late Database database;
createDataBase()async{
var databasesPath = await getDatabasesPath();

String path = join(databasesPath, 'contact.db');
print(databasesPath);
print(path);

 database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Contact (id INTEGER PRIMARY KEY, name TEXT, phone TEXT, status TEXT)'
      );
    },
  onOpen: (database){
    getDataBase(database);
  }
);

}

insertDataBase({String? name , String? phone })async{
  await database.transaction((txn) async {
     await txn.rawInsert(
        'INSERT INTO Contact (name, phone, status) VALUES("$name", "$phone", "NOFavorite")').then((value){
          print("$value inserted successfully");
          getDataBase(database);
     });
});
}


updateDataBase({String? name , String? phone , int?  id })async{
  await database.rawUpdate(
      'UPDATE Contact SET name = ?, phone = ?  WHERE id = ?',
      [name, phone ,id ]).then((value){
        print("$value updated ");
        getDataBase(database);
  });
}

updateStatus({String? status , int? id })async {
  await database.rawUpdate(
      'UPDATE Contact SET status = ?  WHERE id = ?',
      [status, id]).then((value){
        print("$value status updated ");
        getDataBase(database);
  });
}

List<Map> contacts= [];
List<Map> favorite= [];
getDataBase(Database database)async{
  contacts= [];
  favorite= [];
  database.rawQuery('SELECT * FROM Contact').then((value){
    for(Map<String,dynamic> element in value ){
      if(element['status'] == "favorite"){
      favorite.add(element);
      }
        contacts.add(element);
    }

  });
}

deleteContact({int? id })async{
  await database
      .rawDelete('DELETE FROM Contact WHERE id = ?', [id]).then((value){
        print("Delete");
        getDataBase(database);
  });
}


