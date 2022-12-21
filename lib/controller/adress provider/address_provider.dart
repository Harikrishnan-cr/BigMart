import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/model/user%20adress%20model/adressmode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AddressProvide extends ChangeNotifier {
  int value = 0;

  final Map<String, UserAddressModel> _addressDetails = {};

  Map<String, UserAddressModel> get getAddressDetails {
    return _addressDetails;
  }

    Future fetchGusestUserAddressDetails() async {

    _addressDetails.clear();
    
  }

  int changeAddressValue({required data}) {
    value = data;

    notifyListeners();
    return data;
  }

  Future fetchUserAdressDeatils() async {
    final User? user = authInstance.currentUser;

    final userId = user!.uid;

    final DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('usersdetails')
        .doc(userId)
        .get();
    if (userData == null) {
      return;
    } else {
      final limit = userData.get('userAddress').length;

      for (int index = 0; index < limit; index++) {
        // final productId = userData.get('userCart')[index]['productId'];
        // final id = userData.get('userCart')[index]['id'];
        // final productQuantity =
        //     userData.get('userCart')[index]['productQuantity'];
        final houseName = userData.get('userAddress')[index]['houseName'];
        final adressLineOne =
            userData.get('userAddress')[index]['adressLineOne'];
        final adressLineTwo =
            userData.get('userAddress')[index]['adressLineTwo'];
        final pincode =
            int.parse(userData.get('userAddress')[index]['pincode']);
        final phoneNumber =
            int.parse(userData.get('userAddress')[index]['phoneNumber']);
        final id = userData.get('userAddress')[index]['id'];

        _addressDetails.putIfAbsent(id, () {
          return UserAddressModel(
              id: id,
              userId: userId,
              houseName: houseName,
              adressLineOne: adressLineOne,
              adressLineTwo: adressLineTwo,
              pincode: pincode,
              phoneNumber: phoneNumber);

          // CartModel(
          //     id: id, productId: productId, productQuantity: productQuantity);
        });
      }
    }

    notifyListeners();
  }

  Future<void> removeAddress(
      {required String adressLineOne,
      required String adressLineTwo,
      required String houseName,
      required String userId,
      required String phoneNumber,
      required String pincode,
      required String id}) async {
    // final User? user = authInstance.currentUser;

    // final userId = user!.uid;

    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userAddress': FieldValue.arrayRemove([
        {
          'adressLineOne': adressLineOne,
          'adressLineTwo': adressLineTwo,
          'houseName': houseName,
          'userId': userId,
          'phoneNumber': phoneNumber,
          'pincode': pincode,
          'id': id,
        }
      ])
    });
    _addressDetails.remove(id);
    notifyListeners();
  }



   Future<void> updateAdrees(
      {required String adressLineOne,
      required String adressLineTwo,
      required String houseName,
      required String userId,
      required String phoneNumber,
      required String pincode,
      required String id}) async {
    // final User? user = authInstance.currentUser;

    // final userId = user!.uid;

    FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({
      'userAddress': FieldValue.arrayUnion([  
        {
          'adressLineOne': adressLineOne,
          'adressLineTwo': adressLineTwo,
          'houseName': houseName,
          'userId': userId,
          'phoneNumber': phoneNumber,
          'pincode': pincode,
          'id': id,
        }
      ])
    });
    _addressDetails.update(id, (value) => UserAddressModel(houseName: houseName, adressLineOne: adressLineOne, adressLineTwo: adressLineTwo, pincode: int.parse(pincode), phoneNumber: int.parse(phoneNumber), userId: userId, id: id));  
    notifyListeners();
  }
}
