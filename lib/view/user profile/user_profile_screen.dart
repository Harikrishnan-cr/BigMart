import 'dart:developer';

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/settings/settings.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/divider/divider.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/orders%20provider/orders_provider.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:big_mart/view/user%20profile/address_screen/address_screen.dart';
import 'package:big_mart/view/user%20profile/faq/faq.dart';
import 'package:big_mart/view/user%20profile/forget_password/forget_password.dart';
import 'package:big_mart/view/user%20profile/order%20screen/order_screen.dart';
import 'package:big_mart/view/user%20profile/user%20profile%20widget/widget_user_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final double size = 27;
  bool _isLoading = false;
  final User? userLogin = authInstance.currentUser;
  String? name;
  String? email;
  @override
  void initState() {
    getUserData();
    // TODO: implement initState
    super.initState();
  }

  Future getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if (userLogin == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      String _uid = userLogin!.uid;
      final DocumentSnapshot userDetails = await FirebaseFirestore.instance
          .collection('usersdetails')
          .doc(_uid)
          .get();

      if (userDetails == null) {
        return;
      } else {
        setState(() {
          name = userDetails.get('name');
          email = userDetails.get('email');
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    final orderProvider = Provider.of<OrdersProvider>(context,listen: false);
     orderProvider.fetchOrderListDeatils();  
    return Scaffold(
        body: SafeArea(
            child: ListView(
      children: [
        SizedBox(
          width: double.infinity,
          height: 120,
          child: !_isLoading ? Column(
            children: [
              constHeight10,
              constHeight10,
              constHeight10,
              constHeight10,
              Text(
                name == null ? 'Hi,Guest' : 'Hi,$name',
                style: userScreenTextStyle(),
              ),
              Text(
                email ?? '',
                style: userScreenSecondaryTextStyle(),
              ),
              constHeight5,
              const DividerOne()
            ],
          ) : Center(child: CircularProgressIndicator(color: greenColour,),)
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
                color: whiteColour,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 1.5,
                  ),
                ],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {  
                      log('Order');
                      
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const OrderScreen(); 
                      },));
                    },
                    child: UserScreenCardText(
                      userCardTitle: 'Orders',
                      userCardSubTitle: 'Check your order status',
                      userCarsIcons: UserScreenIcons(
                          userIcon: Icons.shopping_cart, size: size),
                    )),
                const DividerOne(),
                GestureDetector(
                    onTap: () {

  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return UserAddressScreen();  
                      },));
                      
                      log('Address pressed');
                    },
                    child: UserScreenCardText(
                      userCardTitle: 'Address',
                      userCardSubTitle: 'Add your address',
                      userCarsIcons: UserScreenIcons(
                          userIcon: Icons.location_on_rounded, size: size),
                    )),
                const DividerOne(),
                GestureDetector(
                    onTap: () {
                      log('Forget Password pressed');
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return ForgetPasswordScreen(); 
                      },));
                    },
                    child: UserScreenCardText(
                      userCardTitle: 'Forget Password',
                      userCardSubTitle: 'Change your password',
                      userCarsIcons: UserScreenIcons(
                          userIcon: Icons.privacy_tip, size: size),
                    )),
                const DividerOne(),
                GestureDetector(
                    onTap: () async{
                          final uriContact = 'mailto:$emial?subject=${Uri.encodeFull(subjectEmail)}'; 

                          try {
                              if (await canLaunchUrl(Uri.parse(uriContact))) {
                                await launchUrl(Uri.parse(uriContact));  
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          log('contact us');
                        },
                    child: UserScreenCardText(
                      userCardTitle: 'Contact us',
                      userCardSubTitle: 'Help regarding your recent purchase',
                      userCarsIcons:
                          UserScreenIcons(userIcon: Icons.message, size: size),
                    )),
              ],
            ),
          ),
        ),
        constHeight10,
        constHeight10,
        constHeight10,
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
                color: whiteColour,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 1.5,
                  ),
                ],
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () {
                      log('FAQ Pressed');
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return FaqScreen(); 
                      },));
                    },
                    child: UserScreenCardTextTwo(
                      userCardTitle: 'FAQ',
                      userCardSubTitle: 'Frequently Asked Question',
                      userCarsIcons: UserScreenIcons(
                          userIcon: Icons.question_answer_outlined, size: size),
                    )),
                const DividerOne(),
                GestureDetector(
                    onTap: ()async{
                            log('Feedba');
                            const urls =
                                'https://www.app-privacy-policy.com/live.php?token=k1nK1xBhoVzjhVrnjg641fHEcuYq98FC'; 
                            try {
                              if (await canLaunchUrl(Uri.parse(urls))) {
                                await launchUrl(Uri.parse(urls));
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          }, 
                    child: UserScreenCardTextTwo(
                      userCardTitle: 'Privacy Policy',
                      userCarsIcons: UserScreenIcons(
                          userIcon: Icons.privacy_tip, size: size),
                    )),
                const DividerOne(),
                 GestureDetector(
                    onTap: ()async{
                            log('Feedba');
                            const urls =
                                'https://www.app-privacy-policy.com/live.php?token=MutQHR0wyVy4eI2Q0NkZeVmJZy95KgaG'; 
                            try {
                              if (await canLaunchUrl(Uri.parse(urls))) { 
                                await launchUrl(Uri.parse(urls));
                              }
                            } catch (e) {
                              log(e.toString());   
                            }
                          }, 
                    child: UserScreenCardTextTwo(
                      userCardTitle: 'Terms And Conditions',
                      userCarsIcons: UserScreenIcons(
                          userIcon: Icons.rule, size: size),
                    )),
                // GestureDetector(
                //     onTap: () {
                //       log('Theme Pressed');
                //     },
                //     child: UserScreenCardTextTwo(
                //       toogleButton: Icons.toggle_on,
                //       userCardTitle: 'Theme',
                //       userCardSubTitle: 'Frequently Asked Question',
                //       userCarsIcons: UserScreenIcons(
                //           userIcon: Icons.light_mode, size: size),
                //     )),
                const DividerOne(),
                GestureDetector(
                    onTap: () async {
                      if (userLogin != null) {
                        log('Log Out');
                        await authInstance.signOut();
                        Navigator.of(context)
                            .pushReplacementNamed(LoginUserScreen.namedRoute);
                        // Navigator.of(context).pushReplacementNamed(LoginUserScreen.namedRoute);
                      } else {
                        log('navigate User');
                        Navigator.of(context)
                            .pushReplacementNamed(LoginUserScreen.namedRoute);
                      }
                    },
                    child: UserScreenCardTextTwo(
                      userCardTitle: userLogin == null ? 'LogIn' : 'Log Out',
                      userCarsIcons:
                          UserScreenIcons(userIcon: Icons.login, size: size),
                    )),
              ],
            ),
          ),
        )
      ],
    )));
  }

  Future callSignUpPage(context) {
    return Navigator.of(context)
        .pushReplacementNamed(LoginUserScreen.namedRoute);
  }
}

class UserScreenIcons extends StatelessWidget {
  const UserScreenIcons({
    Key? key,
    required this.userIcon,
    required this.size,
  }) : super(key: key);

  final IconData userIcon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      userIcon,
      color: blackColour,
      size: size,
    );
  }
}
  