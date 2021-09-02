import 'dart:io';

import 'package:e_fiction_task_ezzat/data/models/cart_model.dart';
import 'package:e_fiction_task_ezzat/ui/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body: Selector<HomeProvider, List<CartModel>>(
        selector: (_, all) {
          return all.cartList;
        },
        builder: (context, pro, child) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              CartModel product = pro[index];
              return CartWidget(product);
            },
            itemCount: pro.length,
          );
        },
      ),
    );
  }

  Padding CartWidget(CartModel product) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black),
        ),
        child: Container(
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Text(
                      "total price : " + "${product.price * product.count}",
                      style: TextStyle(fontSize: 13),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (product.count == 1) {
                                return;
                              }

                              product.count--;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.remove,
                              color: Colors.black,
                            )),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          product.count.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            onPressed: () {
                              if (product.count < product.numInStock) {
                                product.count++;
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.black,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Image.file(
                File(product.img),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/lap.png",
                    width: 100,
                  );
                },
                width: 100,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
