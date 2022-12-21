


import 'package:big_mart/controller/users%20location%20provider/users_location_provider.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:big_mart/view/common/buttons/buttons.dart';
import 'package:big_mart/view/login%20screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LocationScreen extends StatelessWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationTextController = TextEditingController(); 

    return Scaffold(
      appBar: appBarSecondaryCommon(context: context,titleText: 'Chose Location'),   

      body: Consumer<UsersLocationProvider>(
        builder: (context, usersLocationProvider, _) {  
              locationTextController.text = usersLocationProvider.location; 
          return Column(
            children: [ 
              EmailLoginPageControllers(mainemail: 'Your Location', labelEmail: 'Your location', textController: locationTextController, textInputType: TextInputType.none), 
             GestureDetector(
              
              onTap: () async{  
               usersLocationProvider.determinePosition().then((value) => usersLocationProvider.convertLocation(data: value)); 
                
              },
              child: const CommonButtonWithIconTranspernt(height: 45, width: double.infinity, iconSize: 22, textFunction: 'Use Current Location', icon: Icons.location_off_outlined)), 
                 
            ],
          );
        }
      ),
      bottomSheet: GestureDetector(
        onTap: () {
          Navigator.of(context).pop(); 
        },
        child: CommonButtobMain(height: 40 ,titleText: 'Continue',)) 
    ); 
  }
}