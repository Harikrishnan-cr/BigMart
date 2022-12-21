import 'dart:developer';

import 'package:big_mart/controller/adress%20provider/address_provider.dart';
import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/model/user%20adress%20model/adressmode.dart';
import 'package:big_mart/view/common/address/update_address.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOutTileWidget extends StatelessWidget {
  CheckOutTileWidget(
      {Key? key, required this.index, required this.userAddressdata})
      : super(key: key);
  final int index;
  UserAddressModel userAddressdata;

  int _value = 0;
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
      child: Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ], color: whiteColour, borderRadius: BorderRadius.circular(14)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.home_filled,
                          color: greenColour,
                          size: 20,
                        )
                      ],
                    ),
                    constWidth10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Home',
                              style: addressTextStyle(),
                            ),
                            constHeight10,
                            constHeight5,
                            Text(
                              userAddressdata.houseName,
                              style: addressTextStyle(),
                            ),
                            constHeight5,
                            Text(
                              userAddressdata.adressLineOne,
                              style: addressTextStyle(),
                            ),
                            constHeight5,
                            Text(
                              '${userAddressdata.phoneNumber}',
                              style: addressTextStyle(),
                            ),
                            constHeight5,
                            Text(
                              '${userAddressdata.adressLineTwo},${userAddressdata.pincode}',
                              style: addressTextStyle(),
                            ),
                            constHeight10,
                            SizedBox(
                              width: 100,
                              child: Consumer<AddressProvide>(
                                  builder: (context, addressProvide, _) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateAdressScreen(userAddressdata: userAddressdata,),)); 
                                          },
                                          child: Text(
                                            'Edit',
                                            style: voiletTextstyle(),
                                          ),
                                        );
                                      }
                                    ),
                                    GestureDetector(     
                                        onTap: () {
                                          addressProvide.removeAddress(
                                            userId: userAddressdata.userId, 
                                              adressLineOne:
                                                  userAddressdata.adressLineOne,
                                              adressLineTwo:
                                                  userAddressdata.adressLineTwo,
                                              houseName:
                                                  userAddressdata.houseName,
                                              phoneNumber:
                                                  userAddressdata.phoneNumber.toString(),
                                              pincode:
                                                  userAddressdata.pincode.toString() ,
                                              id: userAddressdata
                                                  .id);  
                                        },
                                        child: Text(
                                          'Remove',
                                          style: voiletTextstyle(),
                                        )),
                                  ],
                                );
                              }),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),

                //  Radio(
                //   activeColor: greenColour,

                //   value: widget.userAddressdata.id, groupValue: widget._value, onChanged: (value) {
                //    // widget._value = widget.index;
                //     log('${value.toString()}------------------');
                //     log(widget.index.toString());
                //    setState(() {
                //       widget._value = value as int;
                //    });
                //  },),
                Consumer<AddressProvide>(builder: (context, addressProvide, _) {
                  return Radio(
                    activeColor: greenColour,
                    value: index,
                    groupValue: addressProvide.value,
                    onChanged: (value) {
                      //widget._value = widget.index;
                      // log('${value.toString()}------------------');
//addressProvide.changeAddressValue(data: value);

                      //  setState(() {
                      //     widget._value = value as int;
                      //  });
                    },
                  );
                })
                //  GestureDetector(
                //   onTap: () {
                //     setState(() {
                //       widget._value = !widget._value;

                //     });
                //     log('pressed');
                //     log(widget.index.toString());
                //   },
                //   child:widget._value ? Icon(Icons.radio_button_checked,color: greenColour,)  : Icon(Icons.radio_button_checked,color: blackColour,)),
              ],
            ),
          )),
    );
  }
}

// Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              Column(
//               children: [
//                 Padding(
//                padding: const EdgeInsets.only(left: 7,top: 7),
//                   child: Row(
//                     children: [
//                       Icon(Icons.home_filled,color: greenColour,size: 20,),
//                       constWidth5,
//                       Text('Home',style: addressTextStyle(),)
//                     ],
//                   ),
//                 ),

//                 Padding(
//                padding: const EdgeInsets.only(left: 7,top: 7),
//                   child: Row(

//                     children: [

//                Text('User name',style: addressTextStyle(),),

//                     ],
//                   ),
//                 ),
//               ],
//              ),

//              Icon(Icons.radio_button_checked,color: greenColour,)
//            ],
//          ),
//        ),
