import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

//https://pub.dev/packages/sqflite#-readme-tab-

void main(){
  runApp(MaterialApp(
    title: 'Databases',
    home: new Home(),
  )); 
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Databases'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
    );
  }
}