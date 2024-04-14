import 'package:flutter/material.dart';
import 'package:sqflite_department/view/product_screen.dart';
import 'package:sqflite_department/view/user_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserScreen(),
                  ));
                },
                child: const Text("User Screen")),
            ElevatedButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProductScreen(),
              ));
            }, child: const Text("product Screen")),
            ElevatedButton(onPressed: () {}, child: const Text("Sales Screen")),
          ],
        ),
      )),
    );
  }
}
