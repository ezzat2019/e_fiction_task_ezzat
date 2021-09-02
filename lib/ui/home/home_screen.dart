import 'dart:io';

import 'package:badges/badges.dart';
import 'package:e_fiction_task_ezzat/data/models/cart_model.dart';
import 'package:e_fiction_task_ezzat/data/models/product_model.dart';
import 'package:e_fiction_task_ezzat/ui/home/add_product_screen.dart';
import 'package:e_fiction_task_ezzat/ui/home/cart_screen.dart';
import 'package:e_fiction_task_ezzat/ui/home/favourite_screen.dart';
import 'package:e_fiction_task_ezzat/ui/home/provider/home_provider.dart';
import 'package:e_fiction_task_ezzat/utils/heleprs/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldstate,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: UiHelper.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return FavouriteScreen();
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          Text("Favourites"),
                          SizedBox(
                            width: 12,
                          ),
                          Selector<HomeProvider, int>(
                            selector: (_, p) {
                              return p.favList.length;
                            },
                            builder: (context, value, child) {
                              return Badge(
                                  badgeContent: Text(
                                    value.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red.shade900,
                                  ));
                            },
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: UiHelper.primaryColor,
                      )),
                  Spacer(),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return CartScreen();
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          Selector<HomeProvider, double>(
                            selector: (_, pro) {
                              return pro.totalPrice;
                            },
                            builder: (context, value, child) {
                              return Text(
                                  "Total : " + "${value.toStringAsFixed(1)}");
                            },
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Badge(
                              badgeContent: Selector<HomeProvider, int>(
                                selector: (_, p) {
                                  return p.cartList.length;
                                },
                                builder: (context, value, child) {
                                  return Text(
                                    value.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 8),
                                  );
                                },
                              ),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.black87,
                              ))
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: UiHelper.primaryColor,
                      )),
                ],
              ),
            ),
          ),
          Selector<HomeProvider, List<ProductModel>>(
            selector: (_, all) {
              return all.allProductList;
            },
            builder: (context, pro, child) {
              return Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    ProductModel product = pro[index];
                    return HomeWidget(product, context, index);
                  },
                  itemCount: pro.length,
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddProductScreen();
            },
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Draggable<Object> HomeWidget(
      ProductModel product, BuildContext context, int index) {
    return Draggable(
      onDragEnd: (details) {
        if (product.numInStock == 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("sorry no enough ammount"),
              duration: Duration(milliseconds: 500)));
        } else {
          if (product.priceSale != 0) {
            double price =
                Provider.of<HomeProvider>(context, listen: false).totalPrice;
            price += product.priceSale * product.countNeed;
            Provider.of<HomeProvider>(context, listen: false)
                .updatePrice(price);
            Provider.of<HomeProvider>(context, listen: false).addCartItem(
                CartModel(product.id, product.img_url, product.product_name,
                    product.countNeed, product.priceSale, product.numInStock));
          } else {
            double price =
                Provider.of<HomeProvider>(context, listen: false).totalPrice;
            price += product.price * product.countNeed;
            Provider.of<HomeProvider>(context, listen: false)
                .updatePrice(price);
            Provider.of<HomeProvider>(context, listen: false).addCartItem(
                CartModel(product.id, product.img_url, product.product_name,
                    product.countNeed, product.price, product.numInStock));
          }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("add to cart"),
            duration: Duration(milliseconds: 500),
          ));
        }
      },
      feedback: SizedBox(
        width: 200,
        height: 210,
        child: Card(
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
          child: Column(
            children: [
              Image.file(
                File(
                  product.img_url,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/lap.png",
                    height: 75,
                  );
                },
                height: 75,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.product_name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Selector<HomeProvider, bool>(
                    selector: (_, p) {
                      return p.allProductList[index].isFav;
                    },
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () {
                          if (!product.isFav) {
                            product.isFav = !product.isFav;
                            Provider.of<HomeProvider>(context, listen: false)
                                .updateProductItem(product);
                            Provider.of<HomeProvider>(context, listen: false)
                                .addFavItem(product);
                          } else {
                            product.isFav = !product.isFav;
                            Provider.of<HomeProvider>(context, listen: false)
                                .deleteFavItem(product);
                          }
                        },
                        child: Icon(
                          value ? Icons.favorite : Icons.favorite_outline,
                          color: Colors.red.shade900,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "price",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (product.priceSale == 0)
                    Text(product.price.toStringAsFixed(1),
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                  if (product.priceSale != 0)
                    Text(product.priceSale.toStringAsFixed(1),
                        style: TextStyle(fontSize: 13, color: Colors.green)),
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
      child: SizedBox(
        width: 200,
        height: 210,
        child: Card(
          shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
          child: Column(
            children: [
              Image.file(
                File(
                  product.img_url,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/images/lap.png",
                    height: 75,
                  );
                },
                height: 75,
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.product_name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Selector<HomeProvider, bool>(
                    selector: (_, p) {
                      return p.allProductList[index].isFav;
                    },
                    builder: (context, value, child) {
                      return InkWell(
                        onTap: () {
                          if (!product.isFav) {
                            product.isFav = !product.isFav;
                            Provider.of<HomeProvider>(context, listen: false)
                                .updateProductItem(product);
                            Provider.of<HomeProvider>(context, listen: false)
                                .addFavItem(product);
                          } else {
                            product.isFav = !product.isFav;
                            Provider.of<HomeProvider>(context, listen: false)
                                .deleteFavItem(product);
                          }
                        },
                        child: Icon(
                          value ? Icons.favorite : Icons.favorite_outline,
                          color: Colors.red.shade900,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: 8,
                  )
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "price",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  if (product.priceSale == 0)
                    Text(product.price.toStringAsFixed(1),
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                  if (product.priceSale != 0)
                    Text(product.priceSale.toStringAsFixed(1),
                        style: TextStyle(fontSize: 13, color: Colors.green)),
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
                          if (product.countNeed < product.numInStock) {
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
  }
}
