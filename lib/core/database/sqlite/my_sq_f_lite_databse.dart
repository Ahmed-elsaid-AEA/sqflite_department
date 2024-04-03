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
  final String _productColumnName = "product_id";
  final String _productColumnPrice = "product_price";
  final String _productColumnCount = "product_count";
  final String _salesTable = "sales";
  final String _salesColumnId = "sales_id";
  final String _salesColumnProductName = "sales_product_name";
  final String _salesColumnUserName = "sales_user_name";

  initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String managementDatabaseName = "management.db";
    String realDatabasePath = join(databasesPath, managementDatabaseName);
    int versionDataBase = 1;
    sqFLiteDatabase.openDatabase(
      realDatabasePath,
      onCreate: _onCreate,
      version: versionDataBase,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_userTable "
            "( $_userColumnID INTEGER ,"
            "  $_userColumnUsername TEXT );");
    await db.execute(
      "CREATE TABLE $_productTable"
          " ( $_productColumnId INTEGER ,"
          " $_productColumnName TEXT ,"
          " $_productColumnPrice REAL ,"
          " $_productColumnCount INTEGER );",
    );  await db.execute(
      "CREATE TABLE $_productTable"
          " ( $_productColumnId INTEGER ,"
          " $_productColumnName TEXT ,"
          " $_productColumnPrice REAL ,"
          " $_productColumnCount INTEGER );",
    ); await db.execute(
      "CREATE TABLE $_salesTable"
          " ( $_salesColumnId INTEGER ,"
          " $_salesColumnProductName TEXT ,"
          " $_salesColumnUserName TEXT  );",
    );
  }

  @override
  int delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  int insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  int select() {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  int update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
// users // products // sales
