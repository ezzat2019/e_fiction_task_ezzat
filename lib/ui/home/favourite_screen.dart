import 'dart:io';

import 'package:e_fiction_task_ezzat/data/models/cart_model.dart';
import 'package:e_fiction_task_ezzat/data/models/product_model.dart';
import 'package:e_fiction_task_ezzat/ui/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favourites")),
      body: Selector<HomeProvider, List<ProductModel>>(
        selector: (_, all) {
          return all.favList;
        },
        builder: (context, pro, child) {
          print(pro.length);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (BuildContext context, int index) {
              ProductModel product = pro[index];
              return Draggable(
                feedback: SizedBox(
                  width: 200,
                  height: 210,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black)),
                    child: Column(
                      children: [
                        Image.file(
                          File(
                            product.img_url,
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/lap.png",
                              height: 60,
                            );
                          },
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.black45,
                            thickness: 0.7,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                product.product_name,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                product.isFav = !product.isFav;
                                Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .deleteFavItem(product);
                                setState(() {});
                              },
                              child: Icon(
                                true ? Icons.favorite : Icons.favorite_outline,
                                color: Colors.red.shade900,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                product.desc,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "price",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (product.priceSale == 0)
                              Text(product.price.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black)),
                            if (product.priceSale != 0)
                              Text(product.priceSale.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green)),
                            if (product.priceSale != 0)
                              SizedBox(
                                width: 4,
                              ),
                            if (product.priceSale != 0)
                              Text(product.price.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red.shade700,
                                      decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                        if (product.numInStock != 0)
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "1",
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  )),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
                onDragEnd: (details) {
                  if (product.numInStock == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("sorry no enough ammount"),
                        duration: Duration(milliseconds: 500)));
                  } else {
                    if (product.priceSale != 0) {
                      double price =
                          Provider.of<HomeProvider>(context, listen: false)
                              .totalPrice;
                      price += product.priceSale * product.countNeed;
                      Provider.of<HomeProvider>(context, listen: false)
                          .updatePrice(price);
                      Provider.of<HomeProvider>(context, listen: false)
                          .addCartItem(CartModel(
                              product.id,
                              product.img_url,
                              product.product_name,
                              product.countNeed,
                              product.priceSale,
                              product.numInStock));
                    } else {
                      double price =
                          Provider.of<HomeProvider>(context, listen: false)
                              .totalPrice;
                      price += product.price * product.countNeed;
                      Provider.of<HomeProvider>(context, listen: false)
                          .updatePrice(price);
                      Provider.of<HomeProvider>(context, listen: false)
                          .addCartItem(CartModel(
                              product.id,
                              product.img_url,
                              product.product_name,
                              product.countNeed,
                              product.price,
                              product.numInStock));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("add to cart"),
                      duration: Duration(milliseconds: 500),
                    ));
                  }
                },
                child: SizedBox(
                  width: 200,
                  height: 210,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black)),
                    child: Column(
                      children: [
                        Image.file(
                          File(
                            product.img_url,
                          ),
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/lap.png",
                              height: 60,
                            );
                          },
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(
                            color: Colors.black45,
                            thickness: 0.7,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                product.product_name,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                product.isFav = !product.isFav;
                                Provider.of<HomeProvider>(context,
                                        listen: false)
                                    .deleteFavItem(product);
                                setState(() {});
                              },
                              child: Icon(
                                true ? Icons.favorite : Icons.favorite_outline,
                                color: Colors.red.shade900,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                product.desc,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "price",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            if (product.priceSale == 0)
                              Text(product.price.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black)),
                            if (product.priceSale != 0)
                              Text(product.priceSale.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green)),
                            if (product.priceSale != 0)
                              SizedBox(
                                width: 4,
                              ),
                            if (product.priceSale != 0)
                              Text(product.price.toStringAsFixed(1),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.red.shade700,
                                      decoration: TextDecoration.lineThrough)),
                          ],
                        ),
                        if (product.numInStock != 0)
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (product.countNeed == 1) {
                                      return;
                                    }

                                    product.countNeed--;
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
                                product.countNeed.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (product.countNeed <
                                        product.numInStock) {
                                      product.countNeed++;
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
                ),
              );
            },
            itemCount: pro.length,
          );
        },
      ),
    );
  }
}
