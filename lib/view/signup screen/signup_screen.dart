import 'dart:developer';

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:big_mart/controller/validation_provider/validation_provider.dart';

import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpUserScreen extends StatefulWidget {
  SignUpUserScreen({Key? key}) : super(key: key);
  static const namedRoute = "/SignUpUserScreen";

  @override
  State<SignUpUserScreen> createState() => _SignUpUserScreenState();
}

class _SignUpUserScreenState extends State<SignUpUserScreen> {
  final _emailTextController = TextEditingController();

  final _passwordTextController = TextEditingController();

  final _conformPasswordTextController = TextEditingController();

  final _nameTextController = TextEditingController();

  final _phoneNumberEditingController = TextEditingController();
  bool _isLoading = false;
  void clearFieldFunction() {
    _emailTextController.clear();
    _conformPasswordTextController.clear();
    _nameTextController.clear();
    _phoneNumberEditingController.clear();
    _passwordTextController.clear();
  }

  Future onRegisterButtonPressed(context) async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_passwordTextController.text == _conformPasswordTextController.text) {
        await authInstance.createUserWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passwordTextController.text.trim());

        final User? user = authInstance.currentUser;
        final userId = user!.uid;
        FirebaseFirestore.instance.collection('usersdetails').doc(userId).set({
          'id': userId,
          'name': _nameTextController.text,
          'email': _emailTextController.text.toLowerCase(),
          'phone-number': _phoneNumberEditingController.text,
          'userWishList': [],
          'userCart': [],
          'userAddress': [],
          'createdAt': Timestamp.now()
        });
        clearFieldFunction();
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushReplacementNamed(LoginUserScreen.namedRoute);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
      //Navigator.of(context).pushReplacementNamed(BottomBarScreen.namedRoute);
    } on FirebaseException catch (error) {
      log(error.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(null),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                size: 30,
                color: blackColour,
              )),
          constWidth10,
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Register',
                  style: productScreenTextStyle(),
                ),
                constHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create',
                      style: signUpUserTextStyle(),
                    ),
                    constWidth5,
                    Text(
                      'Account',
                      style: productRsTextStyle(),
                    ),
                  ],
                ),
                constHeight10,
                Text(
                  'Enter your name and email to sign up',
                  style: loginUserScreenSecondaryCardTextStyle(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<ValidationProvider>(
                      builder: (context, validationProvider, _) {
                    return Column(
                      children: [
                        EmailLoginPageControllers(
                          onChanged: (value) {
                            validationProvider.userNameChanges(value);
                          },
                          error: validationProvider.userName.error,
                          mainemail: 'NAME',
                          labelEmail: 'Name',
                          textController: _nameTextController,
                          textInputType: TextInputType.name,
                        ),
                        EmailLoginPageControllers(
                          onChanged: (value) {
                            validationProvider.userEmailChanges(value);
                          },
                          error: validationProvider.userEmail.error,
                          textInputType: TextInputType.emailAddress,
                          mainemail: 'EMAIL',
                          labelEmail: 'Email',
                          textController: _emailTextController,
                        ),
                        EmailLoginPageControllers(
                          onChanged: (value) {
                            validationProvider.userPassWordChanges(value);
                            //log(value.toString());
                          },
                          error: validationProvider.userPasswordLogin.error,  
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          mainemail: 'PASSWORD',
                          labelEmail: 'Password',  
                          textController: _passwordTextController,
                        ),
                        EmailLoginPageControllers(
                          onChanged: (value) {
                            validationProvider.userPassWordLoginChanges(value); 
                          },
                          error: validationProvider.userConfirmPassword.error,
                          textInputType: TextInputType.visiblePassword,
                          obscureText: true,
                          mainemail: 'CONFIRM PASSWORD',
                          labelEmail: 'Confirm password',
                          textController: _conformPasswordTextController,
                        ),
                        EmailLoginPageControllers(
                          onChanged: (value) {
                            validationProvider.userPhoneChanges(value);
                          },
                          error: validationProvider.userPhone.error,
                          textInputType: TextInputType.phone,
                          mainemail: 'PHONE NUMBER',
                          labelEmail: 'Phone Number',
                          textController: _phoneNumberEditingController,
                        ),
                      ],
                    );
                  }),
                ),
                constHeight10,
                Consumer<ValidationProvider>(
                    builder: (context, validationProvider, _) {
                  return GestureDetector(
                      onTap: () async {
                        await onRegisterButtonPressed(context);
                      },
                      child: !_isLoading
                          ? !validationProvider.isFormIsValid
                                ? const CommonButtobMain(  
                                  height: 45,
                                  titleText: 'REGISTER',
                                )
                              : GestureDetector(
                                  onTap: () {
                                    log('sssss pressed');
                                  },
                                  child: const CommonButtobMain(  
                                    height: 45,
                                     titleText: 'REGISTER',
                                    colours: Colors.green,   
                                  ))
                          : Center(
                              child: CircularProgressIndicator(
                                color: greenColour,
                              ),
                            ));
                }),
                constHeight10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: cardTextStyle(),
                    ),
                    constWidth5,
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacementNamed(LoginUserScreen.namedRoute);
                        },
                        child: Text(
                          'Login',
                          style: userLoginTextStyle(),
                        )),
                  ],
                ),
                constHeight10,
                constHeight10,
                constHeight10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
