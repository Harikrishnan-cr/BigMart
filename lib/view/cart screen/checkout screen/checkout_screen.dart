






import 'dart:developer';
import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/view/cart%20screen/cart%20widget/cart_widget.dart';
import 'package:big_mart/view/cart%20screen/checkout%20screen/checkout%20widget/checkouttile.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/common/address/addadress.dart';
import 'package:big_mart/view/common/buttons/buttons.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:big_mart/view/review%20screen/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class CheckOutScreen extends StatelessWidget {
   CheckOutScreen({Key? key}) : super(key: key);
int addValue = 0;
  @override
  Widget build(BuildContext context) {
    final adressProvider =  Provider.of<AddressProvide>(context);
final data =
              adressProvider.getAddressDetails.values.toList();
    return Scaffold(
      appBar: appBarSecondaryCommon(titleText: 'Select Address',context: context),    
      body: data.length != 0 ?  Column(
        children: [
          
          Expanded(child: ListView.builder(
            
            itemCount: data.length,
            itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
               addValue = adressProvider.changeAddressValue(data: index);  
                  
              },
              child: CheckOutTileWidget(index: index,userAddressdata: data[index],));   
          },),),

constHeight10, 
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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return AddAddressScreen();
    },));  
  },
  child: CommonButtonTranspernt(height: 45, width: double.infinity, iconWidth: 22, iconSize: 20, textFunction: 'ADD NEW ADRESS', icon: Icons.add )), 
      bottomNavigationBar: data.length != 0 ?  GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ReviewScreen(adreesdetails: data[addValue],);           
          },));
        },
        child: CommonButtobMain(height: 45,titleText: 'CONTINUE',) ) :  GestureDetector(
          onTap: () {
            showAlertDialogCommonScreen(context: context, itemContent: 'Add address to continue', itemHead: 'No Address Found!');  
          },
          child: CommonButtobMain(height: 45,titleText: 'CONTINUE',  colours: Colors.green,))   
    );
  }
}

