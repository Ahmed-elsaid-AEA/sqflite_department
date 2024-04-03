import 'package:flutter/material.dart'; 
import 'package:sqflite_department/app/my_app.dart';
import 'package:sqflite_department/core/database/sqlite/my_sq_f_lite_databse.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MySqFLiteDatabase db=MySqFLiteDatabase();
  bool inserted=await db.delete();
  print(inserted);
  runApp(const MyApp());
}
