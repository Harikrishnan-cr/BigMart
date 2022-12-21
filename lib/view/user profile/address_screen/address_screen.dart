import 'dart:developer';

import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/common/address/addadress.dart';
import 'package:big_mart/view/common/buttons/buttons.dart';
import 'package:big_mart/view/user%20profile/address_screen/adress_widget/address_widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final adressProvider = Provider.of<AddressProvide>(context);
    final data = adressProvider.getAddressDetails.values.toList();
    log(data.length.toString());   
    return Scaffold(
      appBar: appBarSecondaryCommon(titleText: 'Addres', context: context),
      body: data.length != 0 ? Column(
        children: [
          Expanded(
            child: ListView(
              children: List.generate(data.length,
                  (index) { 
                    
                    return  AddressWidgetTile(userAddressdata: data[index]);
                  
                  }
                  ),
            ),
          ),
          constHeight10, 
          constHeight10,
          constHeight10,
          constHeight10,
          constHeight10,
          constHeight10,
          constHeight10,
        ],
      ) : Center(child: Lottie.asset('assets/address.json'),),  
      bottomSheet: GestureDetector(
          onTap: () {
            log('Add Address');
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const AddAddressScreen();
              },
            ));
          },
          child: const CommonButtonTranspernt(
              height: 45,
              width: double.infinity,
              iconWidth: 22,
              iconSize: 20,
              textFunction: 'ADD NEW ADRESS',
              icon: Icons.add)),
    );
  }
}
