//klasa odpowiedzialna za stworzenie ekranu BD - 2 tabel oraz robieniu operacji typu CRUD

//wzorzec Singleton - tworzenie tylko instancji, zamiast nowych obiektow za kazdym razem
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:testy_nov_p_8/models/user.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  //factory konstruktor pozwala przechowywać stan klasy, co pozwala nam ograniczyc tworzenie obiektow
  factory DatabaseHelper() => _instance;
  //zatem za kazdym razem gdy chcemy odwolac sie do klasy, uzyjemy instancji
  //dzieje sie tak, gdyz chcemy korzystac z 1 BD, a nie tworzyc nowe

  static Database _db;

  final String tableUser = "userTable";
  final String columnId = "id";
  final String columndUserName = "username";
  final String columnPassword = "password";

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "maindb.db");  //home://directory/files/maindb.db

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }
  void _onCreate(Database db, int newVersion) async{
    await db.execute(
      "CREATE TABLE $tableUser($columnId INTEGER PRIMARY KEY, $columndUserName TEXT, $columnPassword TEXT)"
    );
  }

  //==========CRUD - Create/Read/Update/Delete=============
  
  //Insertion
  Future<int> saveUser(User user) async{
    var dbClient = await db;
    int res = await dbClient.insert("$tableUser", user.toMap());
    return res;
  }

  //Get users
  Future<List> getAllUsers() async{
    var dbClient = await db;
    var result = await dbClient.rawQuery('SELECT * FROM $tableUser'); //wybierz wszystkich userow z tej BD i zapisz w zmiennej result

    return result.toList();   //warto dodawac ten .toList(), na wszelki wyps gdyby sie cos jebło, bo chcemy przeciez dostac liste Stringów
  }

  //Get count of users
  Future<int> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(
      await dbClient.rawQuery(
        'SELECT COUNT (*) FROM $tableUser'
      )
    );
  }

  //Get specific user by id
  Future<User> getUser(int id) async{
    var dbClient = await db;

    var result = await dbClient.rawQuery('SELECT * FROM $tableUser WHERE $columnId = $id'); 
    if(result.length == 0) return null;
    return new User.fromMap(result.first);
  }

  //Delete user
  Future<int> deleteUser(int id) async{
    var dbClient = await db;

    return await dbClient.delete(tableUser,
     where: "$columnId = ?", whereArgs: [id]);
  }

  //Updatowanie usera
  Future<int> updateUser(User user) async{
    var dbClient = await db;
    return await dbClient.update(tableUser, 
    user.toMap(), where: "$columnId = ?", whereArgs: [user.id]);
  }

  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }

}
