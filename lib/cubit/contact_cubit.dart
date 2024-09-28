import 'package:bloc/bloc.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import "package:path/path.dart";


part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactInitial());
  static ContactCubit get(context)=>BlocProvider.of(context);

// state
 // 1- loading
 // 2- success
 // 3- error

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
          emit(GetDataBaseStates());
        }
    );

  }

  insertDataBase({String? name , String? phone })async{
    await database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO Contact (name, phone, status) VALUES("$name", "$phone", "NOFavorite")').then((value){
        print("$value inserted successfully");
        getDataBase(database);
        emit(InsertDataBaseSuccessStates());
      }).catchError((error){
        print(error);
        emit(InsertDataBaseErrorStates());
      });
    });
  }


  updateDataBase({String? name , String? phone , required int  id })async{
    await database.rawUpdate(
        'UPDATE Contact SET name = ?, phone = ?  WHERE id = ?',
        [name, phone ,id ]).then((value){
      print("$value updated ");
      getDataBase(database);
      emit(UpdateDataBaseSuccessStates());
    }).catchError((error){
      print(error);
      emit(UpdateDataBaseErrorStates());
    });
  }

  updateStatus({String? status , int? id })async {
    await database.rawUpdate(
        'UPDATE Contact SET status = ?  WHERE id = ?',
        [status, id]).then((value){
      print("$value status updated ");
      getDataBase(database);
      emit(UpdateFavoriteSuccessStates());
    });
  }

  List<Map> contacts= [];
  List<Map> favorite= [];
  getDataBase(Database database)async{
    emit(LoadingGetDataBaseStates());
    contacts= [];
    favorite= [];
    database.rawQuery('SELECT * FROM Contact').then((value){
      for(Map<String,dynamic> element in value ){
        if(element['status'] == "favorite"){
          favorite.add(element);
        }
        contacts.add(element);
      }

      emit(SuccessGetDataBaseStates());

    }).catchError((error){
      emit(ErrorGetDataBaseStates());
    });
  }

  deleteContact({int? id })async{
    await database
        .rawDelete('DELETE FROM Contact WHERE id = ?', [id]).then((value){
      print("Delete");
      getDataBase(database);
      emit(DeleteDataBaseErrorStates());
    });
  }




  var isBottom= false;
  IconData  floatingIcon= Icons.account_circle_sharp;
  void changeBottom({required bool isShow,required IconData icon}){
    isBottom = isShow;
    floatingIcon = icon;
    emit(ChangeBottomSheetStates());
  }

  var currentIndex= 0 ;
  void changeBottomNavBar(int index){

    currentIndex = index;
    emit(ChangeBottomNavBarStates());
  }
}
