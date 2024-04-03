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
  Database? _db;

  Future<Database> initDatabase() async {
    String databasesPath = await sqFLiteDatabase.getDatabasesPath();
    String managementDatabaseName = "management.db";
    String realDatabasePath = join(databasesPath, managementDatabaseName);
    int versionDataBase = 1;
    _db ??= await sqFLiteDatabase.openDatabase(
      realDatabasePath,
      onCreate: _onCreate,
      version: versionDataBase,
    );
    return _db!;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXCIT $_userTable "
        "( $_userColumnID INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "  $_userColumnUsername TEXT  );");
    await db.execute(
      "CREATE TABLE IF NOT EXCIT $_productTable"
      " ( $_productColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $_productColumnName TEXT ,"
      " $_productColumnPrice REAL ,"
      " $_productColumnCount INTEGER );",
    );
    await db.execute(
      "CREATE TABLE IF NOT EXCIT $_salesTable"
      " ( $_salesColumnId INTEGER PRIMARY KEY AUTOINCREMENT,"
      " $_salesColumnProductName TEXT ,"
      " $_salesColumnUserName TEXT  );",
    );
  }

  @override
  Future<int> delete() {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<int> insert() async {
    // TODO: implement insert
    await initDatabase();
    int inserted = await _db!.insert(
      _userTable,
      {
        _userColumnUsername: "ahmed",
      },
    );
    return inserted;
  }

  @override
  Future<int> select() {
    // TODO: implement select
    throw UnimplementedError();
  }

  @override
  Future<int> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
// users // products // sales
