import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import './utils/database_helper.dart';
import 'models/user.dart';

//https://pub.dev/packages/sqflite#-readme-tab-


List _users;

void main() async{
  var db = new DatabaseHelper();

  //======add user=====
//await db.saveUser(new User('Brian', 'adams'));

//=====retrieving a user====
User ana = await db.getUser(2);
User anaUpdated = User.fromMap({"username": "updatedAna", "password": "UpdatedPassword", 'id': 6});


//====deleting a user =====
//int userDeleted = await db.deleteUser(5);
//print("Delete user: $userDeleted");

//====updating a user====
await db.updateUser(anaUpdated);


//===couting all users====
int count = await db.getCount();
print("Count: $count");

  //get all users
  _users = await db.getAllUsers();
  for(int i=0; i<_users.length; i++){
    User user = User.map(_users[i]);        //jako ze metoda getAllUsers zwraca liste, trzeba ich zmapowac na typ User
    print("Username: ${user.username}, User id: ${user.id}");
  }

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
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int position){
          return Card(
            color: Colors.pink.shade100,
            elevation: 4.0,
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${User.fromMap(_users[position]).id}'),
              ),
              title: Text("User: ${User.fromMap(_users[position]).username}"),  //wyswietlenie nazwy usera
              subtitle: Text("ID: ${User.fromMap(_users[position]).id}"),

              onTap: () => debugPrint("${User.fromMap(_users[position]).password}"),
            ),
          );
        },
      ),
    );
  }
}