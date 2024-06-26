import 'package:sqflite/sqflite.dart';
import 'package:sqflite_department/core/database/sqlite/crud.dart';
import 'package:sqflite/sqflite.dart' as sqFLiteDatabase;
import 'package:path/path.dart';

class MySqFLiteDatabase extends CRUD {
  final String _userTable = "user";
  final String _userColumnID = "user_id";
  final String _userColumnUsername = "username";
  final String _productTable = "product";
  final String _productColumnId = "product_id";
  final String _productColumnName = "product_name";
  final String _productColumnPrice = "product_price";
  final String _productColumnCount = "product_count";
  final String _salesTable = "sales";
  final String _salesColumnId = "sales_id";
  final String _salesColumnProductID = "sales_product_ID";
  final String _salesColumnUserID = "sales_user_ID";
  Database? _db;

  Future<Database> _initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String managementDatabaseName = "management.db";
    String realDatabasePath = join(databasesPath, managementDatabaseName);
    int versionDataBase = 41;
    _db ??= await sqFLiteDatabase.openDatabase(
      realDatabasePath,
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
      onUpgrade: (db, oldVersion, newVersion) {
        print(db);
        print(oldVersion);
        print(newVersion);
      },
      version: versionDataBase,
    );
    return _db!;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $_userTable "
        "( $_userColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $_userColumnUsername TEXT  );");
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $_productTable"
      " ( $_productColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $_productColumnName TEXT ,"
      " $_productColumnPrice REAL ,"
      " $_productColumnCount INTEGER );",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXISTS $_salesTable"
      " ( $_salesColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $_salesColumnProductID INTEGER ,"
      " $_salesColumnUserID INTEGER  , "
      " CONSTRAINT user_sales_relation FOREIGN KEY ($_salesColumnProductID) REFERENCES $_productTable ($_productColumnId) ON DELETE CASCADE ON UPDATE CASCADE ,"
      " CONSTRAINT product_sales_relation FOREIGN KEY ($_salesColumnUserID) REFERENCES $_userTable ($_userColumnID) ON DELETE CASCADE ON UPDATE CASCADE "
      " );",
    );
  }

  Future<bool> deleteUserTable({required int id}) async {
    return delete(tableName: _userTable, where: "$_userColumnID==$id");
  }

  Future<bool> deleteProductTable({required int id}) async {
    return delete(tableName: _productTable, where: "$_productColumnId==$id");
  }

  @override
  Future<bool> delete(
      {required String tableName, required String where}) async {
    await _initDatabase();
    int deleted = await _db!.delete(
      tableName,
      where: where,
    );
    await _db!.close();
    return deleted > 0 ? true : false;
  }

  Future<bool> insertToUserTable({required String userName}) async {
    return insert(
      tableName: _userTable,
      values: {_userColumnUsername: userName},
    );
  }

  Future<bool> insertToSalesTable(
      {required int userID, required int productID}) async {
    return insert(
      tableName: _salesTable,
      values: {
        _salesColumnUserID: userID,
        _salesColumnProductID: productID,
      },
    );
  }

  Future<bool> insertToProductTable(
      {required String name, required double price, required int count}) async {
    return insert(
      tableName: _productTable,
      values: {
        _productColumnName: name,
        _productColumnPrice: price,
        _productColumnCount: count,
      },
    );
  }

  @override
  Future<bool> insert(
      {required String tableName, required Map<String, Object?> values}) async {
    // TODO: implement insert
    await _initDatabase();
    int inserted = await _db!.insert(tableName, values);
    await _db!.close();
    return inserted > 0 ? true : false;
  }

  Future<List<Map<String, Object?>>> selectUserTableData() async {
    return select(tableName: _userTable);
  }

  Future<List<Map<String, Object?>>> selectProductsTableData() async {
    return select(tableName: _productTable);
  }

  Future<List<Map<String, Object?>>> sales() async {
    return select(tableName: _salesTable);
  }

  @override
  Future<List<Map<String, Object?>>> select({
    required String tableName,
  }) async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.query(tableName);
    await _db!.close();
    return data;
  }

  Future<List<Map<String, Object?>>> selectSalesTableData() async {
    await _initDatabase();
    List<Map<String, Object?>> data = await _db!.rawQuery(
        'SELECT $_salesTable.$_salesColumnId,'
        '$_productTable.$_productColumnName,'
        '$_userTable.$_userColumnUsername'
        ' FROM $_salesTable,$_userTable,$_productTable WHERE '
        '$_salesTable.$_salesColumnUserID =$_userTable.$_userColumnID AND '
        '$_salesTable.$_salesColumnProductID =$_productTable.$_productColumnId');

    await _db!.close();
    return data;
  }

  Future<bool> updateUserTable(
      {required String userName, required int id}) async {
    return update(
        tableName: _userTable,
        values: {_userColumnUsername: userName},
        where: "$_userColumnID==$id");
  }

  Future<bool> updateProductTable({
    required String productName,
    required double productPrice,
    required int productCount,
    required int id,
  }) async {
    return update(
        tableName: _productTable,
        values: {
          _productColumnName: productName,
          _productColumnPrice: productCount,
          _productColumnCount: productCount,
        },
        where: "$_productColumnId==$id");
  }

  @override
  Future<bool> update(
      {required String tableName,
      required Map<String, Object?> values,
      required String where}) async {
    await _initDatabase();
    int deleted = await _db!.update(tableName, values, where: where);
    await _db!.close();
    return deleted > 0 ? true : false;
  }
}
// users // products // sales
