


import 'package:big_mart/view/categories/categories%20widget/categories_widget.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/common/catagory%20details/category_details.dart';


import 'package:flutter/material.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(titleText: 'Categories',context: context),
      body: GridView.count(crossAxisCount: 2,
      children: [
        GestureDetector(
          onTap: () {
    
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const CatagoryDetailsScreen(ctaName: 'Meat');  
            },)); 
          },   
          child: CategoriesCardWidget(categoryTitle: 'Meat',imgUrl: 'https://images.unsplash.com/photo-1607623814075-e51df1bdc82f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')),
          GestureDetector(
          onTap: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CatagoryDetailsScreen(ctaName: 'Vegetables');   
            },));
          },
          child: CategoriesCardWidget(categoryTitle: 'Vegetables',imgUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')), 
          GestureDetector(
          onTap: () {
            
           Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CatagoryDetailsScreen(ctaName: 'Fish');  
            },)); 
          },
          child: CategoriesCardWidget(categoryTitle: 'Fish',imgUrl: 'https://images.unsplash.com/photo-1517115358639-5720b8e02219?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1174&q=80')),
          GestureDetector(
          onTap: () {
 Navigator.of(context).push(MaterialPageRoute(builder: (context) {  
              return CatagoryDetailsScreen(ctaName: 'Fruit');    
            },));
          },
          child: CategoriesCardWidget(categoryTitle: 'Fruits',imgUrl: 'https://images.unsplash.com/photo-1519996529931-28324d5a630e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',)),
          GestureDetector(
          onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return CatagoryDetailsScreen(ctaName: 'others');  
            },));
          },
          child: CategoriesCardWidget(categoryTitle: 'Others',imgUrl: 'https://images.unsplash.com/photo-1509358271058-acd22cc93898?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')),
       
      ]
      ),
      );  
    
  }
}


//List.generate(8, (index) {
      //  return const CategoriesCardWidget();
      //}