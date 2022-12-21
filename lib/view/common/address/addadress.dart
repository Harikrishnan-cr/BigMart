



import 'dart:developer';


import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/validation_provider/validation_provider.dart';

import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:uuid/uuid.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { 

    final addressProvider = Provider.of<AddressProvide>(context);

  final _houseNameTextController = TextEditingController();

  final _adressOneTextController = TextEditingController();

  final _adresstwoTextController = TextEditingController();

  final _phoneTextController = TextEditingController();
  final _pincodeEditingController = TextEditingController();

    return Scaffold(
      appBar: appBarSecondaryCommon(titleText: 'ADD NEW ADDRESS',context: context),  
      body: Padding(  
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ValidationProvider>(
          builder: (ontext, validationProvider, _) {
            return ListView(
              children: [
EmailLoginPageControllers(
  onChanged: (value) {
    validationProvider.userHouseChanges(value);
  },
 error: validationProvider.userHouseName.error,
  textInputType: TextInputType.name,
  mainemail: 'House Name', labelEmail: 'House Name', textController: _houseNameTextController),
EmailLoginPageControllers(
   onChanged: (value) {
    validationProvider.userAddressLineOneChanges(value);
  },
 error: validationProvider.userAddressLineOne.error,
  // error: 'add',
  textInputType: TextInputType.streetAddress,
  mainemail: 'Address Line One', labelEmail: 'Address Line One', textController: _adressOneTextController),
EmailLoginPageControllers(
     onChanged: (value) {
    validationProvider.userAddressLineTwoChanges(value);
  },
 error: validationProvider.userAddressLineTwo.error,   
  // error: 'add',
  textInputType: TextInputType.streetAddress, 
  mainemail: 'Address Line Two', labelEmail: 'Address Line Two', textController: _adresstwoTextController),
EmailLoginPageControllers(
  onChanged: (value) {
    validationProvider.userPhoneChanges(value);  
  },
  error: validationProvider.userPhone.error,
  textInputType: TextInputType.phone,
  mainemail: 'Phone Number', labelEmail: 'hone Number', textController: _phoneTextController),
EmailLoginPageControllers(
  onChanged: (value) {
      validationProvider.userPincodeChanges(value);  
  },
  error: validationProvider.userPincode.error,
  textInputType: TextInputType.number, 
  mainemail: 'Pin Code', labelEmail: 'Pin Code', textController: _pincodeEditingController),
constHeight10,  
GestureDetector(
  onTap: () {
    // final List<UserAddressModel> userAddressList = [];
    final User? user = authInstance.currentUser;

    final userId = user!.uid;
    
    final adreesId = const Uuid().v4();

    try {
      FirebaseFirestore.instance.collection('usersdetails').doc(userId).update({ 
            'userAddress': FieldValue.arrayUnion([{
              'id':adreesId,
              'userId':userId, 
              'houseName':_houseNameTextController.text,
              'adressLineOne':_adressOneTextController.text,
                'adressLineTwo':_adresstwoTextController.text,
                'pincode':_pincodeEditingController.text,
                'phoneNumber':_phoneTextController.text,  
            }
              
            //  UserAddressModel(houseName: _houseNameTextController.text, adressLineOne: _houseNameTextController.text, adressLineTwo: _houseNameTextController.text, pincode: 5555, phoneNumber: 888)
            ]) 

             
      });


  _houseNameTextController.clear(); 
_adressOneTextController.clear(); 
_adresstwoTextController.clear(); 
_phoneTextController.clear(); 
_pincodeEditingController.clear(); 
addressProvider.fetchUserAdressDeatils(); 
Navigator.of(context).pop(); 
    } catch (e) {
      log(e.toString()); 
    }  
  },
  child:validationProvider.isAddressFormIsValid == true ? CommonButtobMain(height: 40,titleText: 'ADD',):GestureDetector(
    onTap: () {
      log('Add Not Working'); 
    },
    child: CommonButtobMain(height: 40,titleText: 'ADD',colours: Colors.green,))),
              ],
            );
          }
        ),
      ),
    );
  }
}