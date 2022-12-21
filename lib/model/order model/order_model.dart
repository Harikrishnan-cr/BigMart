import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String orderId;
  String userId;
  String productId;
  String imgUrl;
  String userName;
  String productName;
  String status;
  String userPhone;
  String addressOne;
  String addressTwo;
  String houseName;
  String paymentType;
  num price;
  num totalPrice;
  int noOfProducts;
  int productQuantity;
  Timestamp orderDate;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.imgUrl,
      required this.userName,
      required this.price,
      required this.paymentType,
      required this.addressOne,
      required this.addressTwo,
      required this.status,
      required this.houseName,
      required this.productName, 
      required this.totalPrice,
      required this.noOfProducts,
      required this.userPhone, 
      required this.productQuantity,
      required this.orderDate});
}
