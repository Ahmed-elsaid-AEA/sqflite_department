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
                      print(value);
                      setState(() {});
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
                    onChanged: (value) {
                      _salesController.valueButtonProducts =
                          int.parse(value.toString());
                      print(value);
                      setState(() {});
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('refresh')),
                  ElevatedButton(
                      onPressed: () {
                        _salesController.insertToSales();
                        _salesController.selectSales();
                        setState(() {});
                      },
                      child: Text('add')),
                  ElevatedButton(
                      onPressed: () {
                        _salesController.selectSales();
                      },
                      child: Text('getData')),
                ],
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                          // onTap: () {
                          //   int id = _userController.dataUser[index]['user_id'];
                          //   _usernameEditController.text =
                          //   _userController.dataUser[index]['username'];
                          //   showModalBottomSheet(
                          //     context: context,
                          //     builder: (context) => Container(
                          //       padding: EdgeInsets.all(20),
                          //       child: Column(
                          //         children: [
                          //           TextField(
                          //             controller: _usernameEditController,
                          //             decoration: const InputDecoration(
                          //               label: Text("username"),
                          //               border: OutlineInputBorder(),
                          //             ),
                          //           ),
                          //           Row(
                          //             children: [
                          //               ElevatedButton(
                          //                   onPressed: () async {
                          //                     _userController.updateUser(
                          //                         userName:
                          //                         _usernameEditController.text,
                          //                         id: id);
                          //                     Navigator.of(context).pop();
                          //                     setState(() {});
                          //                   },
                          //                   child: const Text("update")),
                          //               ElevatedButton(
                          //                   onPressed: () async {
                          //                     _userController.deleteUser(id: id);
                          //                     Navigator.of(context).pop();
                          //                     setState(() {});
                          //                   },
                          //                   child: const Text("delete")),
                          //             ],
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //   );
                          // },
                          child: Row(
                            children: [
                              Text(
                                  "id : ${_salesController.dataSales[index]['sales_user_name']}   "),
                              Text(
                                  "name : ${_salesController.dataSales[index]['sales_product_name']}"),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: _salesController.dataSales.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
