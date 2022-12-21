

import 'package:flutter/cupertino.dart';

class BottomBarProvider with ChangeNotifier{
  int name = 25;
 
    int _selectedIndex = 0;
    int get selectedIndex => _selectedIndex;
  bottomBarChanged({int? index}){
_selectedIndex = index!;
notifyListeners();

  }


  
}