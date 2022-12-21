import 'dart:developer';

import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/model/cart%20model/cart_model.dart';
import 'package:big_mart/model/product%20model/product_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

double cartTotal = 0;

void cartTotalAssign(total) {
  cartTotal = total;
}

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  num totalPrice = 0.0;

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  Future addProductsToCartFunction({
    required String productId,
    required int itemQuantity,
    required num productPrice,
  }) async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    final cartId = const Uuid().v4();

    try {
      FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
        'userCart': FieldValue.arrayUnion([
          {
            'id': cartId,
            'productId': productId,
            'productQuantity': itemQuantity,
          }
        ])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future fetchGusestUserCartItems() async {
    _cartItems.clear();
  }

  Future fetchUserCartItems() async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    final DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('usersdetails')
        .doc(userId)
        .get();
    if (userData == null) {
      return;
    } else {
      final limit = userData.get('userCart').length;

      for (int index = 0; index < limit; index++) {
        final productId = userData.get('userCart')[index]['productId'];
        final id = userData.get('userCart')[index]['id'];
        final productQuantity =
            userData.get('userCart')[index]['productQuantity'];
        _cartItems.putIfAbsent(productId, () {
          return CartModel(
              id: id, productId: productId, productQuantity: productQuantity);
        });
      }
    }

    notifyListeners();
  }

  // void addProductsToCart(
  //     {required String productId, required int itemQuantity}) {
  //   _cartItems.putIfAbsent(
  //       productId,
  //       () => CartModel(
  //           id: DateTime.now().toString(),
  //           productId: productId,
  //           productQuantity: itemQuantity));

  //   notifyListeners();
  // }

  void reduceQuantityByOne(
      {required String productId,
      required int productQuantity,
      required num productPrice,
      required String id}) {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;
    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userCart': FieldValue.arrayUnion([
        {
          'id': id,
          'productId': productId,
          'productQuantity': productQuantity - 1,
        }
      ])
    });

    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userCart': FieldValue.arrayRemove([
        {
          'id': id,
          'productId': productId,
          'productQuantity': productQuantity,
        }
      ])
    });

    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id,
            productId: productId,
            productQuantity: value.productQuantity - 1));
    notifyListeners();
  }

  void increaseQuantityByOne(
      {required String productId,
      required int productQuantity,
      required num productPrice,
      required String id}) async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;
    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userCart': FieldValue.arrayUnion([
        {
          'id': id,
          'productId': productId,
          'productQuantity': productQuantity + 1,
        }
      ])
    });

    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userCart': FieldValue.arrayRemove([
        {
          'id': id,
          'productId': productId,
          'productQuantity': productQuantity,
        }
      ])
    });

    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id,
            productId: productId,
            productQuantity: value.productQuantity + 1));
    notifyListeners();
  }

  Future<void> removeItem(
      {required String productId,
      required int productQuantity,
      required String id}) async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userCart': FieldValue.arrayRemove([
        {
          'id': id,
          'productId': productId,
          'productQuantity': productQuantity,
        }
      ])
    });
    _cartItems.remove(productId);
    notifyListeners();
  }

  num cartTotalPrice(
      {required ProductModel getProducts, required int productQuantity}) {
    totalPrice += getProducts.discountPrice * productQuantity;

    notifyListeners();

    return totalPrice;
  }

  void clearMyCart() async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;
    await FirebaseFirestore.instance
        .collection('usersdetails')
        .doc(userId)
        .update({'userCart': []});

    _cartItems.clear();
    notifyListeners();
  }
}
