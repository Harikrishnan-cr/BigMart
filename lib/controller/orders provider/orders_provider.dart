

import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/model/order%20model/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orderList = [];

  List<OrderModel> get getOrderList {
    return _orderList;
  }

  Future<void> fetchGuestUserOrderListDeatils() async {
    _orderList.clear(); 
  }

  Future<void> fetchOrderListDeatils() async {
    final User? user = authInstance.currentUser;

    // ignore: avoid_single_cascade_in_expression_statements
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user!.uid)
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orderList.clear();
      for (var data in ordersSnapshot.docs) {
        _orderList.insert(
            0,
            OrderModel(
                orderId: data.get('orderId'),
                paymentType: data.get('payment-type'), 
                addressOne: data.get('addressOne'),
                addressTwo: data.get('addressTwo'),
                houseName: data.get('houseName'), 
                userPhone: data.get('userPhone').toString(),    
                userId: data.get('userId'),
                productId: data.get('productId'),
                imgUrl: data.get('imgUrl'),
                userName: data.get('userName'),
                price: data.get('price'),
                status: data.get('status'),
                productName: data.get('productName'),
                totalPrice: data.get('totalPrice'),
                noOfProducts: data.get('noOfProducts'),
                productQuantity: data.get('productQuantity'),
                orderDate: data.get('orderDate')));
                
               
      }
    });
  }
}
