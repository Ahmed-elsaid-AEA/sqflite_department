import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class UserController {
  UserController(){
    select();
  }
  void insertUser({required String userName}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    bool inserted = await db.insertToUserTable(userName: userName);
    print(inserted);
  }

  Future<List<Map<String, Object?>>> select() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    List<Map<String, Object?>> data = await db.select();
    print(data);
    return data;
  }
}
