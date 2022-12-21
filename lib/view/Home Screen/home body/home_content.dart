





import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/view/common/Product%20tile/product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenContentOrderBYDate extends StatelessWidget {
  const HomeScreenContentOrderBYDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {  
   final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
        int listLength = productsProvider.getProductList.length;
    return Scaffold(
     body: ListView(
    
      scrollDirection: Axis.horizontal,    
       children: List.generate(listLength > 10 ? 10 : listLength , (index) {
return  GestureDetector(
  child: ProductTile(products: productsProvider.getProductList[index],)); 
       })
         
       
     ),
    );
  }
}




class HomeScreenContentOrderBYDiscount extends StatelessWidget {
  const HomeScreenContentOrderBYDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {  
   final productsProvider =
        Provider.of<ProductProvider>(context, listen: false);
        int listLength = productsProvider.getProductsListDiscontRange.length;
    return Scaffold(
     body: ListView(
    
      scrollDirection: Axis.horizontal,    
       children: List.generate(listLength > 10 ? 10 : listLength , (index) {  
return  GestureDetector(
  child: ProductTile(products: productsProvider.getProductsListDiscontRange[index],));  
       })
         
       
     ),
    );
  }
}