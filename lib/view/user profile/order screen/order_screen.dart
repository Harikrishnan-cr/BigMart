


import 'package:big_mart/controller/orders%20provider/orders_provider.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/orders_full_details.dart/orders.dart';
import 'package:big_mart/view/user%20profile/order%20screen/order%20widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // final orderProvoder = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: appBarSecondaryCommon(titleText: 'Orders', context: context),   
      body: Consumer<OrdersProvider>(
        builder: (context, ordersProvider,_) { 
          return ordersProvider.getOrderList.length != 0 ? ListView( 
            children: List.generate(ordersProvider.getOrderList.length, (index) {
              final list = ordersProvider.getOrderList;           
              // final data = list.reversed.toList();

              list.sort((a, b) => a.orderDate.compareTo(b.orderDate));
              final data = list.reversed.toList();
//orderProvoder.getOrderList.sort((a,b)=> a.orderDate.compareTo(b.orderDate));
              return GestureDetector(
                onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return OrdersFullDetails(orderList: data[index]);     
                },)); 
                },
                child: OrderWidget(
                  orderList: data[index],      
                ),
              );
            }),
          ) : Center(child: Lottie.asset('assets/orders.json',),);         
        }
      ),
    );
  }
}
