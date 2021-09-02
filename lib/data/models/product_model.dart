class ProductModel {
  int id;
  String img_url;
  String product_name;
  String desc;
  double price;
  double priceSale;
  bool isFav;
  int numInStock;
  int countNeed = 1;

  ProductModel(this.id, this.img_url, this.product_name, this.desc, this.price,
      this.priceSale, this.isFav, this.numInStock);
}
