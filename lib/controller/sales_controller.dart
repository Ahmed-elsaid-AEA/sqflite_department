import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

class SalesController {
  List dataUser = [];
  List dataProducts = [];
  List dataSales = [];

  int? valueButtonUsers;

  int? valueButtonProducts;

  SalesController() {
    init();
  }

  void init() async {
    await selectUsers();
    if (dataUser.isNotEmpty) valueButtonUsers = dataUser[0]['user_id'];
    await selectProducts();
    if (dataProducts.isNotEmpty)
      valueButtonProducts = dataProducts[0]['product_id'];
  }

  Future<void> selectUsers() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataUser = await db.selectUserTableData();
  }

  Future<void> insertToSales() async {
    if (valueButtonUsers != null && valueButtonProducts != null) {

      MySqFLiteDatabase db = MySqFLiteDatabase();
      bool inserted = await db.insertToSalesTable(
          userID: valueButtonUsers!, productID: valueButtonProducts!);
      print(inserted);
    }
  }

  Future<void> selectProducts() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataProducts = await db.selectProductsTableData();
  }

  Future<void> selectSales() async {
    MySqFLiteDatabase db = MySqFLiteDatabase();
    dataSales = await db.selectSalesTableData();
    print(dataSales);
  }
}
