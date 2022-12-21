



import 'package:flutter/cupertino.dart';

class ReviewProvider with ChangeNotifier{

 dynamic value = 0;

void changeValueRadio(input){

  value = input;
  notifyListeners(); 
}


}