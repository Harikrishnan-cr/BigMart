import 'dart:developer';

import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/validation_provider/validation_provider.dart';
import 'package:big_mart/model/user%20adress%20model/adressmode.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UpdateAdressScreen extends StatelessWidget {
  const UpdateAdressScreen({Key? key, required this.userAddressdata})
      : super(key: key);
  final UserAddressModel userAddressdata;
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvide>(context);

    final houseNameTextController = TextEditingController();

    final adressOneTextController = TextEditingController();

    final adresstwoTextController = TextEditingController();

    final phoneTextController = TextEditingController();
    final pincodeEditingController = TextEditingController();

    houseNameTextController.text = userAddressdata.houseName;
    adressOneTextController.text = userAddressdata.adressLineOne;
    adresstwoTextController.text = userAddressdata.adressLineTwo;
    phoneTextController.text = userAddressdata.phoneNumber.toString();
    pincodeEditingController.text = userAddressdata.pincode.toString();

    return Scaffold(
      appBar:
          appBarSecondaryCommon(context: context, titleText: 'Edit Address'),
      body: Consumer<ValidationProvider>(
          builder: (ontext, validationProvider, _) {
        return ListView(
          children: [
            EmailLoginPageControllers(
                onChanged: (value) {
                  validationProvider.userHouseChanges(value);
                },
                error: validationProvider.userHouseName.error,
                textInputType: TextInputType.name,
                mainemail: 'House Name',
                labelEmail: 'House Name',
                textController: houseNameTextController),
            EmailLoginPageControllers(
                onChanged: (value) {
                  validationProvider.userAddressLineOneChanges(value);
                },
                error: validationProvider.userAddressLineOne.error,
                // error: 'add',
                textInputType: TextInputType.streetAddress,
                mainemail: 'Address Line One',
                labelEmail: 'Address Line One',
                textController: adressOneTextController),
            EmailLoginPageControllers(
                onChanged: (value) {
                  validationProvider.userAddressLineTwoChanges(value);
                },
                error: validationProvider.userAddressLineTwo.error,
                // error: 'add',
                textInputType: TextInputType.streetAddress,
                mainemail: 'Address Line Two',
                labelEmail: 'Address Line Two',
                textController: adresstwoTextController),
            EmailLoginPageControllers(
                onChanged: (value) {
                  validationProvider.userPhoneChanges(value);
                },
                error: validationProvider.userPhone.error,
                textInputType: TextInputType.phone,
                mainemail: 'Phone Number',
                labelEmail: 'hone Number',
                textController: phoneTextController),
            EmailLoginPageControllers(
                onChanged: (value) {
                  validationProvider.userPincodeChanges(value);
                },
                error: validationProvider.userPincode.error,
                textInputType: TextInputType.number,
                mainemail: 'Pin Code',
                labelEmail: 'Pin Code',
                textController: pincodeEditingController),
            constHeight10,
            GestureDetector(
                onTap: () {
                  // final List<UserAddressModel> userAddressList = [];
//  final User? user = authInstance.currentUser;

//   final userId = user!.uid;

//     final adreesId = const Uuid().v4();

                  try {
                    addressProvider.removeAddress(
                        adressLineOne: userAddressdata.adressLineOne,
                        adressLineTwo: userAddressdata.adressLineTwo,
                        houseName: userAddressdata.houseName,
                        userId: userAddressdata.userId,
                        phoneNumber: userAddressdata.phoneNumber.toString(),
                        pincode: userAddressdata.pincode.toString(),
                        id: userAddressdata.id);
                    FirebaseFirestore.instance
                        .collection('usersdetails')
                        .doc(userAddressdata.userId)
                        .update({
                      'userAddress': FieldValue.arrayUnion([
                        {
                          'id': userAddressdata.id,
                          'userId': userAddressdata.userId,
                          'houseName': houseNameTextController.text,
                          'adressLineOne': adressOneTextController.text,
                          'adressLineTwo': adresstwoTextController.text,
                          'pincode': pincodeEditingController.text,
                          'phoneNumber': phoneTextController.text,
                        }

                        //  UserAddressModel(houseName: _houseNameTextController.text, adressLineOne: _houseNameTextController.text, adressLineTwo: _houseNameTextController.text, pincode: 5555, phoneNumber: 888)
                      ])
                    });

                    // FirebaseFirestore.instance.collection('usersdetails').doc(userAddressdata.userId).update({

                    //       'userAddress': FieldValue.arrayRemove([{
                    //         'id':userAddressdata.id,
                    //         'userId':userAddressdata.userId,
                    //         'houseName':userAddressdata.houseName,
                    //         'adressLineOne':userAddressdata.adressLineOne,
                    //           'adressLineTwo':userAddressdata.adressLineTwo,
                    //           'pincode':userAddressdata.pincode,
                    //           'phoneNumber':userAddressdata.phoneNumber,
                    //       }

                    //       //  UserAddressModel(houseName: _houseNameTextController.text, adressLineOne: _houseNameTextController.text, adressLineTwo: _houseNameTextController.text, pincode: 5555, phoneNumber: 888)
                    //       ])

                    // });

                    houseNameTextController.clear();
                    adressOneTextController.clear();
                    adresstwoTextController.clear();
                    phoneTextController.clear();
                    pincodeEditingController.clear();
                    addressProvider.fetchUserAdressDeatils();
                    Navigator.of(context).pop();
                  } catch (e) {
                    log(e.toString());
                  }
                },
                child:  CommonButtobMain(   
                        height: 40,
                        titleText: 'Update',
                      )
                    // : GestureDetector(
                    //     onTap: () {
                    //       log('Add Not Working');
                    //     },
                    //     child: CommonButtobMain(
                    //       height: 40,
                    //       titleText: 'Update',
                    //       colours: Colors.green,
                    //     ))
                        
                        ),
          ],
        );
      }),
    );
  }
}
