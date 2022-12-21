import 'package:big_mart/model/product%20model/product_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {
  final List<ProductModel> _productsList = [];

  List<ProductModel> get getProductList {
    return _productsList;
  }



   final List<ProductModel> _productsListDiscontRange = [];

  List<ProductModel> get getProductsListDiscontRange {
    return _productsListDiscontRange;
  }




   Future<void> fetchProductsOnTheBasisOfDiscount() async {
    await FirebaseFirestore.instance
        .collection('productsadmin')
        .orderBy('discount',descending: false)    
        .get()
        .then((QuerySnapshot productsSnapshot) {
      for (var data in productsSnapshot.docs) {
        // log(data.get('title'));
        _productsListDiscontRange.insert(
            0,
            ProductModel(
                id: data.get('id'),
                categories: data.get('category'),
                description: data.get('description'),
                discount: int.parse(data.get('discount')),
                discountPrice: int.parse(data.get('price')) -
                    (int.parse(data.get('price')) *
                        int.parse(data.get('discount')) /
                        100),
                imgUrl: data.get('imgUrl'),
                price: int.parse(data.get('price')),
                title: data.get('title')));
      }
    });
  }

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('productsadmin')
        .orderBy('createdAt', descending: false)
        .get()
        .then((QuerySnapshot productsSnapshot) {
      for (var data in productsSnapshot.docs) {
        // log(data.get('title'));
        _productsList.insert(
            0,
            ProductModel(
                id: data.get('id'),
                categories: data.get('category'),
                description: data.get('description'),
                discount: int.parse(data.get('discount')),
                discountPrice: int.parse(data.get('price')) -
                    (int.parse(data.get('price')) *
                        int.parse(data.get('discount')) /
                        100),
                imgUrl: data.get('imgUrl'),
                price: int.parse(data.get('price')),
                title: data.get('title')));
      }
    });
  }

  ProductModel findProductById({required String productId}) {
    return _productsList.firstWhere((element) => element.id == productId);
  }

  List<ProductModel> findProductByCatagoryName(String categoriesName) {
    List<ProductModel> catgaryList = _productsList
        .where((element) => element.categories
            .toLowerCase()
            .contains(categoriesName.toLowerCase()))
        .toList();

    return catgaryList;
  }

  List<ProductModel> serschProducttByTiltle({required String searchQuery}) {
    List<ProductModel> searchProductsList = _productsList
        .where((element) => element.title
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return searchProductsList;
  }
}
