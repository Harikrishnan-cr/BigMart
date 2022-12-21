// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/text_style.dart';

import 'package:flutter/material.dart';

// class UserScreenCardText extends StatelessWidget {
//   const UserScreenCardText({
//     Key? key,
//     required this.userCarsIcons,
//     required this.userCardTitle,
//     required this.userCardSubTitle,
//   }) : super(key: key);

//   final Icon userCarsIcons;
//   final String userCardTitle;
//   final String userCardSubTitle;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 15 ),
//       child: Container(
//         width: double.infinity,
//         height: 220,
//        decoration: BoxDecoration(
//          color: whiteColour,
//            boxShadow: const [
//           BoxShadow(
//             color: Colors.grey,
//             offset: Offset(0.0, 1.0), //(x,y)
//             blurRadius: 1.5,
//           ),
//         ],
//          borderRadius: BorderRadius.circular(12)
//        ),
//        child: Column(
//          children: [

//            Padding(
//              padding: const EdgeInsets.only(top: 10,left: 10,right: 10),
//              child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(

//                   children: [
//                     Column(
//                       children: [
//                         userCarsIcons
//                       ],
//                     ),
//                     constWidth10,
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(userCardTitle,style: userScreenCardTextStyle(),),
//                         Text(userCardSubTitle ,style: userScreenSecondaryCardTextStyle(),)
//                       ],
//                     )
//                   ],
//                 ),

//                 Row(
//                   children: const [
//                     Icon(Icons.arrow_forward_ios_outlined)
//                   ],
//                 )
//               ],
//              ),
//            ),
//            const DividerOne()
//          ],
//        ),
//       ),
//     );
//   }
// }

class UserScreenCardText extends StatelessWidget {
  const UserScreenCardText({
    Key? key,
    required this.userCarsIcons,
    required this.userCardTitle,
    required this.userCardSubTitle,
  }) : super(key: key);
  final userCarsIcons;
  final String userCardTitle;
  final String userCardSubTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [userCarsIcons],
                  ),
                  constWidth10,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userCardTitle,
                        style: userScreenTextStyle(),
                      ),
                      Text(
                        userCardSubTitle,
                        style: userScreenSecondaryTextStyle(),
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: const [Icon(Icons.arrow_forward_ios_outlined)],
              )
            ],
          ),
        ),
      ],
    );
  }
}











class UserScreenCardTextTwo extends StatelessWidget {
  const UserScreenCardTextTwo({
    Key? key,
    required this.userCarsIcons,
    required this.userCardTitle,
    this.toogleButton,
    this.userCardSubTitle,
  }) : super(key: key);
  final dynamic userCarsIcons;
  final dynamic toogleButton;
  final String userCardTitle;
  final String? userCardSubTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    children: [userCarsIcons],
                  ),
                  constWidth10,
                  userCardSubTitle != null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userCardTitle,
                              style: userScreenTextStyle(),
                            ),
                            Text(
                              userCardSubTitle!,
                              style: userScreenSecondaryTextStyle(),
                            )
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userCardTitle,
                              style: userScreenTextStyle(),
                            ),
                          ],
                        )
                ],
              ),
              toogleButton != null
                  ? Row(
                      children: [
                        Icon(
                          toogleButton,
                          size: 40,
                          color: greenColour,
                        )
                      ],
                    )
                  : Row(
                      children: const [],
                    )
            ],
          ),
        ),
      ],
    );
  }
}
