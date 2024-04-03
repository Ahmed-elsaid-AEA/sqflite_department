import 'package:flutter/material.dart';
import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              label: Text("username"),
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(onPressed: () async{
            MySqFLiteDatabase db=MySqFLiteDatabase();
            bool inserted=await db.insertToUserTable(userName: _usernameController.text);
            print(inserted);
          }, child: const Text("inserted")),
        ],
      ),
    ));
  }
}
