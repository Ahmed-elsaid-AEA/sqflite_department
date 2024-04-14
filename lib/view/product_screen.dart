import 'package:flutter/material.dart';
import 'package:sqflite_department/controller/product_controller.dart';
import 'package:sqflite_department/controller/user_controller.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productEditController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productCountController = TextEditingController();
  late ProductController _productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productController = ProductController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("product Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _productNameController,
                decoration: const InputDecoration(
                  label: Text("product Name"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: _productPriceController,
                decoration: const InputDecoration(
                  label: Text("price"),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _productCountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("count"),
                  border: OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    _productController.insertProduct(
                        name: _productNameController.text,
                        price: double.parse(_productPriceController.text),
                        count: int.parse(_productCountController.text));

                    setState(() {});
                  },
                  child: const Text("inserted")),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {});
                  },
                  child: const Text("refresh")),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            // int id =
                            //     _productController.dataUser[index]['user_id'];
                            // _productEditController.text =
                            //     _productController.dataUser[index]['username'];
                            // showModalBottomSheet(
                            //   context: context,
                            //   builder: (context) => Container(
                            //     padding: const EdgeInsets.all(20),
                            //     child: Column(
                            //       children: [
                            //         TextField(
                            //           controller: _productEditController,
                            //           decoration: const InputDecoration(
                            //             label: Text("username"),
                            //             border: OutlineInputBorder(),
                            //           ),
                            //         ),
                            //         Row(
                            //           children: [
                            //             ElevatedButton(
                            //                 onPressed: () async {
                            //                   _productController.updateUser(
                            //                       userName:
                            //                           _productEditController
                            //                               .text,
                            //                       id: id);
                            //                   Navigator.of(context).pop();
                            //                   setState(() {});
                            //                 },
                            //                 child: const Text("update")),
                            //             ElevatedButton(
                            //                 onPressed: () async {
                            //                   _productController.deleteUser(
                            //                       id: id);
                            //                   Navigator.of(context).pop();
                            //                   setState(() {});
                            //                 },
                            //                 child: const Text("delete")),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Row(
                            children: [
                              Text(
                                  "id : ${_productController.dataProduct[index]['product_id']}  "),
                              Text(
                                  "name : ${_productController.dataProduct[index]['product_name']}  "),
                              Text(
                                  "price : ${_productController.dataProduct[index]['product_price']}  "),
                              Text(
                                  "count : ${_productController.dataProduct[index]['product_count']}"),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: _productController.dataProduct.length),
              )
            ],
          ),
        ));
  }
}
