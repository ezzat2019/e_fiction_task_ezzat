import 'package:e_fiction_task_ezzat/data/models/cart_model.dart';
import 'package:e_fiction_task_ezzat/data/models/product_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<ProductModel> favList = [];
  List<ProductModel> allProductList = [];
  List<CartModel> cartList = [];
  double totalPrice = 0000.0;

  void updatePrice(double total) {
    totalPrice = total;
    notifyListeners();
  }

  void addCartItem(CartModel cartModel) {
    this.cartList = [...cartList, cartModel];
    notifyListeners();
  }

  void addFavItem(ProductModel productModel) {
    this.favList = [...favList, productModel];
    notifyListeners();
  }

  void deleteFavItem(ProductModel productModel) {
    updateProductItem(productModel);
    this.favList.removeWhere((element) => element.id == productModel.id);
    notifyListeners();
  }

  void updateProductItem(ProductModel productModel) {
    this.allProductList[allProductList
        .indexWhere((element) => element.id == productModel.id)] = productModel;
    notifyListeners();
  }

  void addProductItem(ProductModel productModel) {
    this.allProductList = [...allProductList, productModel];
    notifyListeners();
  }
}
