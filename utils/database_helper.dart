//klasa odpowiedzialna za stworzenie ekranu BD - 2 tabel oraz robieniu operacji typu CRUD

//wzorzec Singleton - tworzenie tylko instancji, zamiast nowych obiektow za kazdym razem
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  //factory konstruktor pozwala przechowywać stan klasy, co pozwala nam ograniczyc tworzenie obiektow
  factory DatabaseHelper() => _instance;
  //zatem za kazdym razem gdy chcemy odwolac sie do klasy, uzyjemy instancji
  //dzieje sie tak, gdyz chcemy korzystac z 1 BD, a nie tworzyc nowe

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {}
}
