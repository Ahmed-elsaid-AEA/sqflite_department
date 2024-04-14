import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class ProductController {
  List dataProduct = [];

  ProductController() {
    select();
  }

  void insertProduct(
      {required String name, required double price, required int count}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
   bool a= await db.insertToProductTable(name: name, price: price, count: count);
   print(a);
    select();
  }

  void select() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProduct = await db.selectProductsTableData();
  }

  void updateUser({required String userName, required int id}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.updateUserTable(userName: userName, id: id);
    select();
  }

  void deleteUser({required int id}) async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    await db.deleteUserTable(id: id);
    select();
  }
}
