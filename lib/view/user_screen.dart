import 'package:flutter/material.dart';
import 'package:sqflite_department/controller/user_controller.dart';
import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _usernameEditController = TextEditingController();
  late UserController _userController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userController = UserController();
  }

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
          ElevatedButton(
              onPressed: () async {
                _userController.insertUser(userName: _usernameController.text);

                setState(() {});
              },
              child: const Text("inserted")),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        int id = _userController.dataUser[index]['user_id'];
                        _usernameEditController.text =
                            _userController.dataUser[index]['username'];
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _usernameEditController,
                                  decoration: const InputDecoration(
                                    label: Text("username"),
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          _userController.updateUser(
                                              userName:
                                                  _usernameEditController.text,
                                              id: id);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        child: const Text("update")),
                                    ElevatedButton(
                                        onPressed: () async {
                                          _userController.insertUser(
                                              userName:
                                                  _usernameController.text);

                                          setState(() {});
                                        },
                                        child: const Text("delete")),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                              "id : ${_userController.dataUser[index]['user_id']}   "),
                          Text(
                              "name : ${_userController.dataUser[index]['username']}"),
                        ],
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 10,
                    ),
                itemCount: _userController.dataUser.length),
          )
        ],
      ),
    ));
  }
}
