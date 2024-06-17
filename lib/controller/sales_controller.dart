import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class SalesController {
  List dataUser = [];
  List dataProducts = [];

  int? valueButtonUsers;

  int? valueButtonProducts;

  SalesController() {
    init();
  }

  void init() async {
    await selectUsers();
    valueButtonUsers = dataUser[0]['user_id'];
   await selectProducts();
  }

  Future<void> selectUsers() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUser = await db.selectUserTableData();
  }

  Future<void> selectProducts() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProducts = await db.selectProductsTableData();
    valueButtonProducts = dataProducts[0]['product_id'];
  }
}
