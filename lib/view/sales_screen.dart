import 'package:flutter/material.dart';
import 'package:sqflite_department/controller/sales_controller.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  late SalesController _salesController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _salesController = SalesController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sales screen"),
      ),
      body: FutureBuilder(
        future: _salesController.selectUsers(),
        builder: (context, snapshot) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Text("users"),
                  SizedBox(
                    width: 100,
                  ),
                  DropdownButton(
                    value: _salesController.valueButtonUsers,
                    items: [
                      for (int i = 0; i < _salesController.dataUser.length; i++)
                        DropdownMenuItem(
                            value: _salesController.dataUser[i]['user_id'],
                            child:
                                Text(_salesController.dataUser[i]['username']))
                    ],
                    onChanged: (value) {
                      _salesController.valueButtonUsers =
                          int.parse(value.toString());
                      setState(() {});
                      print(value);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text("Products"),
                  SizedBox(
                    width: 100,
                  ),
                  DropdownButton(
                    onChanged: (value) {
                      _salesController.valueButtonProducts =
                          int.parse(value.toString());
                      setState(() {});
                    },
                    value: _salesController.valueButtonProducts,
                    items: [
                      for (int i = 0;
                          i < _salesController.dataProducts.length;
                          i++)
                        DropdownMenuItem(
                            value: _salesController.dataProducts[i]
                                ['product_id'],
                            child: Text(
                                '${_salesController.dataProducts[i]['product_name']} /  ${_salesController.dataProducts[i]['product_price']}'))
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                ElevatedButton(onPressed: () {
                  
                }, child: Text("add")), SizedBox(width: 20,),ElevatedButton(onPressed: () {
                  setState(() {

                  });
                }, child: Text("refresh"))
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
