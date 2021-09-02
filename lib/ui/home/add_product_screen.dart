import 'dart:io';

import 'package:e_fiction_task_ezzat/data/models/product_model.dart';
import 'package:e_fiction_task_ezzat/ui/home/provider/home_provider.dart';
import 'package:e_fiction_task_ezzat/utils/heleprs/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  HomeProvider? homeProvider;
  final _productNameController = TextEditingController();
  final _descController = TextEditingController();
  final _priceController = TextEditingController();

  bool correctProductName = false;
  bool correctPrice = false;
  bool correctDesc = false;
  bool correctNum = false;
  final _salePriceController = TextEditingController();
  final _numController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? imgUrl = null;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            if (imgUrl == null)
              Image.asset(
                "assets/images/lap.png",
                height: 150,
              ),
            if (imgUrl != null)
              Image.file(
                File(
                  imgUrl!.path,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/lap.png",
                    height: 150,
                  );
                },
                height: 150,
              ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                getImage().then((value) {
                  setState(() {
                    imgUrl = value;
                  });
                });
              },
              child: Text(
                "Pick Image From Gallery",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(primary: UiHelper.secondaryColor),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                getImageCamera().then((value) {
                  setState(() {
                    imgUrl = value;
                  });
                });
              },
              child: Text(
                "Pick Image From Camera",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(primary: UiHelper.secondaryColor),
            ),
            SizedBox(
              height: 12,
            ),
            Text("Product Details :"),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _productNameController,
              decoration: InputDecoration(
                  labelText: "Product Name:",
                  errorText:
                      !correctProductName ? null : "please enter product name",
                  labelStyle: TextStyle(color: UiHelper.primaryColor),
                  focusColor: Colors.black,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                  labelText: "Descreption ",
                  errorText: !correctDesc ? null : "please enter Descreption ",
                  labelStyle: TextStyle(color: UiHelper.primaryColor),
                  focusColor: Colors.black,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
                controller: _priceController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                    labelText: "Price ",
                    errorText: !correctPrice ? null : "please enter price",
                    labelStyle: TextStyle(color: UiHelper.primaryColor),
                    focusColor: Colors.black,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black))),
                keyboardType: TextInputType.number),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _salePriceController,
              decoration: InputDecoration(
                  labelText: "Sale Price",
                  labelStyle: TextStyle(color: UiHelper.primaryColor),
                  focusColor: Colors.black,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 32,
            ),
            TextField(
              controller: _numController,
              decoration: InputDecoration(
                  labelText: "number of product",
                  labelStyle: TextStyle(color: UiHelper.primaryColor),
                  errorText: !correctNum ? null : "please enter number of item",
                  focusColor: Colors.black,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 22),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black))),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    String nameProduct = _productNameController.text.trim();
                    String desc = _descController.text.trim();
                    String price = _priceController.text.trim();
                    String salePrice = _salePriceController.text.trim();
                    String numStock = _numController.text.trim();
                    String img =
                        imgUrl == null ? "assets/images/lap.png" : imgUrl!.path;
                    double ss = 0;

                    if (salePrice.isEmpty) {
                      ss = 0;
                    } else {
                      ss = double.parse(salePrice);
                    }

                    if (_checkProductFeilds(
                        nameProduct, desc, price, numStock)) {
                      int id = (homeProvider!.allProductList.length - 1);
                      id++;
                      homeProvider!.addProductItem(ProductModel(
                          id,
                          img,
                          nameProduct,
                          desc,
                          double.parse(price),
                          ss,
                          false,
                          int.parse(numStock)));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("success add"),
                        duration: Duration(milliseconds: 500),
                      ));

                      imgUrl = null;
                      _productNameController.clear();
                      _descController.clear();
                      _priceController.clear();
                      _salePriceController.clear();
                      _numController.clear();
                      setState(() {});
                    }
                  },
                  child: Text(
                    "Done",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: UiHelper.secondaryColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<XFile> getImage() async {
    final res = await _picker.pickImage(source: ImageSource.gallery);
    return res!;
  }

  Future<XFile> getImageCamera() async {
    final res = await _picker.pickImage(source: ImageSource.camera);
    return res!;
  }

  bool _checkProductFeilds(
      String nameProduct, String desc, String price, String num) {
    if (nameProduct.isEmpty) {
      setState(() {
        correctProductName = !correctProductName;
      });
      return false;
    } else {
      correctProductName = false;
      setState(() {});
    }
    if (desc.isEmpty) {
      setState(() {
        correctDesc = !correctDesc;
      });
      return false;
    } else {
      correctDesc = false;
      setState(() {});
    }
    if (price.isEmpty) {
      setState(() {
        correctPrice = !correctPrice;
      });
      return false;
    } else {
      correctPrice = false;
      setState(() {});
    }
    if (num.isEmpty) {
      setState(() {
        correctNum = !correctNum;
      });
      return false;
    } else {
      correctNum = false;
      setState(() {});
    }
    return true;
  }
}
