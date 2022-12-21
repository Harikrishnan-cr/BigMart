




import 'dart:developer';

import 'package:big_mart/controller/const/firebase/auth_firebase.dart';
import 'package:big_mart/controller/validation_provider/validation_provider.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final forgetPasswordText = TextEditingController(); 
    return Scaffold(
      appBar: appBarSecondaryCommon(context: context,titleText: 'Forget Password'),
      body: SingleChildScrollView(
        child: Consumer<ValidationProvider>(
          builder: (context, validationProvider, _) {
            return Column(
              children: [
                EmailLoginPageControllers(
                  error: validationProvider.userEmail.error,
                  onChanged: (value) {
                  validationProvider.userForgetEmailChanges(value);  
                  },
                  mainemail: 'Email', labelEmail: 'Enter Email', textController: forgetPasswordText, textInputType: TextInputType.emailAddress),
 
               validationProvider.ispasswordEmailValidc == true ? GestureDetector(
                onTap: () async{
                  try{
await authInstance.sendPasswordResetEmail(email: forgetPasswordText.text.toLowerCase());
  final snackBar = SnackBar(
    padding: EdgeInsets.all(10),
        content: Text('A password reset message was sent to your email address'),  
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
Navigator.of(context).pop();    
                  }on FirebaseException catch (error) {
                    log('errrrrr');
      log(error.toString());
      final snackBar = SnackBar(
        content: Text(error.message.toString()),  
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
         log('errrrrr two');
      log('${e.toString()} -----------------');
    }
                },
                child: const CommonButtobMain(height: 45,titleText: 'Reset Now',)):const CommonButtobMain(height: 45,titleText: 'Reset Now',colours: Colors.green,)
               ],
            ); 
          }
        ),
      ),
    );
  }
}