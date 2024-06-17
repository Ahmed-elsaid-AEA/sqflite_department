import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class SalesController {
  List dataUser = [];
  List dataProducts = [];

  int? valueButtonUsers;

  int valueButtonProducts = 0;

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

  Future<void> insertToSales() async {
    String userName = "";
    String productName = "";
    if (valueButtonUsers != null) {
      for (int i = 0; i < dataUser.length; i++) {
        if (dataUser[i]['user_id'] == valueButtonUsers) {
          userName = dataUser[i]['username'];
        }
      }

      ///
      for (int i = 0; i < dataProducts.length; i++) {
        if (dataProducts[i]['product_id'] == valueButtonProducts) {
          productName = dataProducts[i]['product_name'];
        }
      }
      MySqFLiteDatabase db = MySqFLiteDatabase();
      bool inserted = await db.insertToSalesTable(
          userName: userName, productName: productName);
      print(inserted);
    }

  }

  Future<void> selectProducts() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProducts = await db.selectProductsTableData();
    valueButtonProducts = dataProducts[0]['product_id'];
  }
}
