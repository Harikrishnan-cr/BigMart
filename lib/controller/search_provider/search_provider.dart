import 'package:big_mart/model/product%20model/product_models.dart';
import 'package:flutter/cupertino.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController searchControlle = TextEditingController();

  void changeSeachFeild({value}) {
    searchControlle.text = value;
    notifyListeners();
  }


   List<ProductModel> serschProducttByTiltle({required String searchQuery,required List<ProductModel> productsList}) {
    List<ProductModel> searchProductsList = productsList
        .where((element) => element.categories
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();

    return searchProductsList;
  }
}
