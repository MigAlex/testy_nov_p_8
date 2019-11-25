import 'package:flutter/material.dart';

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