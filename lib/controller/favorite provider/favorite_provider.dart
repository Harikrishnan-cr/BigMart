import 'dart:developer';

import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/model/favorite%20model/favorite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class FavoriteProider extends ChangeNotifier {
  final Map<String, FavoriteModel> _favariteItems = {};

  Map<String, FavoriteModel> get getFavoriteItems {
    return _favariteItems;
  }


Future fetchGuestUserWishListItems() async {
  _favariteItems.clear(); 
}

  Future addProductsToWishLIstFunction({required String productId}) async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    // final cartId = const Uuid().v4();

    try {
      FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
        'userWishList': FieldValue.arrayUnion([
          {
            'id': userId,  
            'productId': productId,
          }
        ])
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future fetchUserWishListItems() async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    final DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('usersdetails')
        .doc(userId)
        .get();
    if (userData == null) {
      return;
    } else {
      final limit = userData.get('userWishList').length; 

      for (int index = 0; index < limit; index++) {
        final productId = userData.get('userWishList')[index]['productId'];
        final id = userData.get('userWishList')[index]['id'];  
        // final productQuantity =
        //     userData.get('userCart')[index]['productQuantity'];
        _favariteItems.putIfAbsent(productId, () {
          return FavoriteModel(id: id, productId: productId);
        });
      }
    }

    notifyListeners();
  }

  void addAndRemoveProductOnFavorite({required String productsId}) {
      final User? user = authInstance.currentUser;

    final userId = user!.uid;
    if (_favariteItems.containsKey(productsId)) {
      removeFavoriteItem(productsId: productsId, id:userId);
    } else {
      addProductsToWishLIstFunction(productId: productsId);
      _favariteItems.putIfAbsent(
          productsId,
          () => FavoriteModel(
              id: DateTime.now().toString(), productId: productsId));
    }
    notifyListeners();
  }

  void removeFavoriteItem({required String productsId, String? id}) {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userWishList': FieldValue.arrayRemove([
        {
          'id': id,
          'productId': productsId,
        }
      ])
    });

    _favariteItems.remove(productsId);
    notifyListeners();
  }
}
