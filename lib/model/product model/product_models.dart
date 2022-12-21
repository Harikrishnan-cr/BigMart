class ProductModel {
  String title, description, id, imgUrl, categories;
  num price, discountPrice,discount;

  ProductModel(
      {required this.id,
      required this.categories,
      required this.description,
      required this.discount,
      required this.discountPrice,
      required this.imgUrl,
      required this.price,
      required this.title});
}
