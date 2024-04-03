import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class UserController {
  List dataUser = [];

  UserController() {
    select();
  }

  void insertUser({required String userName}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    bool inserted = await db.insertToUserTable(userName: userName);
    select();
  }

  void select() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUser = await db.selectUserTableData();
  }
}
