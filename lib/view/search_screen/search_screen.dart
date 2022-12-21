import 'dart:developer';


import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/product%20provider/product_provider.dart';
import 'package:big_mart/controller/search_provider/search_provider.dart';
import 'package:big_mart/view/likes%20screen/liked%20widget/liked_screen_card.dart';
import 'package:big_mart/view/search_screen/search_widget/search_widget.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsprovider = Provider.of<ProductProvider>(context,listen: false); 
    log('build once search');
    return SafeArea(
      child: Scaffold(
          body: Consumer<SearchProvider>(builder: (context, searchProvider, _) {
           final searchList =  productsprovider.serschProducttByTiltle(searchQuery:searchProvider.searchControlle.text ); 
        return Column(
          children: [
            SearchWidget(
                text: searchProvider.searchControlle.text,
                onChanged: (value) {
                  searchProvider.changeSeachFeild(value: value);
                  //  searchController.text = value;
                  //    log(searchController.text);
                },
                hintText: 'Type product name to search'),
            Expanded(
                child:searchList.length != 0 ?
                
                 ListView.builder(
              itemCount: searchList.length,
              itemBuilder: (context, index) {  
                return FavoritesScreenCard(products: searchList[index]);  
              },
            ):Container(
              child: Column(
                children: [
                  Lottie.asset('assets/search.json',repeat: false),  
                  constHeight10, 
                  constHeight10,   
                  Text('No Result',style: likedCardTextStyle(),)
                ],
              )
            )
            )
          ],
        );
      })),
    );
  }
}
