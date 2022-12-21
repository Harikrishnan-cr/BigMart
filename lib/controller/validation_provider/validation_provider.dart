// ignore_for_file: prefer_final_fields

import 'package:big_mart/model/validation_model/validation_model.dart';
import 'package:flutter/cupertino.dart';

class ValidationProvider with ChangeNotifier {
  ValidationValues _userName = ValidationValues(error: null, value: null);
  // ValidationValues _userAge = ValidationValues(error: null, value: null);
  ValidationValues _userPhone = ValidationValues(error: null, value: null);
  // ValidationValues _userDob = ValidationValues(error: null, value: null);
  ValidationValues _userEmail = ValidationValues(error: null, value: null);
  ValidationValues _userPassword = ValidationValues(error: null, value: null);
  ValidationValues _userPasswordLogin = ValidationValues(error: null, value: null);
  ValidationValues _userPincode = ValidationValues(error: null, value: null);
  ValidationValues _userHouseName = ValidationValues(error: null, value: null);
  ValidationValues _userAddressLineOne = ValidationValues(error: null, value: null);
  ValidationValues _userAddressLineTwo = ValidationValues(error: null, value: null);
  ValidationValues _userConfirmPassword =
      ValidationValues(error: null, value: null);

  ValidationValues get userName => _userName;
  ValidationValues get userEmail => _userEmail;
  ValidationValues get userPassword => _userPassword;
  ValidationValues get userPasswordLogin => _userPasswordLogin;
  ValidationValues get userConfirmPassword => _userConfirmPassword;
  ValidationValues get userPincode => _userPincode;
  ValidationValues get userHouseName => _userHouseName;
  ValidationValues get userAddressLineOne => _userAddressLineOne;
  ValidationValues get userAddressLineTwo => _userAddressLineTwo;
  // ValidationValues get userAge => _userAge;
  ValidationValues get userPhone => _userPhone;
  // ValidationValues get userDob => _userDob;

  bool isPasswordValid = false;
  bool isEmailValidc = false;
  bool isAddressValid = false;
  bool ispasswordEmailValidc = false;
  String password = '';
  bool isEmailValid(email) {
    String emailData =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(emailData);

    return regExp.hasMatch(email);
  }

  // bool isPasswordValid(password) {
  //   String passwordData =
  //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';

  //   RegExp regExp = RegExp(passwordData);

  //   return regExp.hasMatch(password);
  // }

  bool get isFormIsValid {
    if (_userName.value != null &&
      _userEmail.value != null &&
        _userPhone.value != null && 
        _userPasswordLogin.value !=null   
        
      ) {
      return true;
    } else {
      return false;
    }
  }


    bool get isAddressFormIsValid {
    if (_userHouseName.value != null &&
      _userAddressLineOne.value != null &&
        _userAddressLineOne.value != null && 
        _userPhone.value !=null &&
        _userPincode.value != null 
      ) {
      return true;
    } else {
      return false;
    }
  }

  void userNameChanges(String value) {
    if (value.length > 3) {
      _userHouseName = ValidationValues(error: null, value: value);
    } else {
      _userHouseName = ValidationValues(error: 'Enter A Valid Name', value: null);
    }
    notifyListeners();
  }



  void userHouseChanges(String value) {
    if (value.length > 3) {
      _userHouseName = ValidationValues(error: null, value: value);
      isAddressValid = true;
    } else {
      _userHouseName = ValidationValues(error: 'Enter A Valid Name', value: null);
      isAddressValid = false;
    }
    notifyListeners();
  }

   void userAddressLineOneChanges(String value) {
    if (value.length > 3) {
      _userAddressLineOne = ValidationValues(error: null, value: value);
       isAddressValid = true;
    } else {
      _userAddressLineOne = ValidationValues(error: 'Enter A Valid Address', value: null);
       isAddressValid = false;
    }
    notifyListeners();
  }

    void userAddressLineTwoChanges(String value) {
    if (value.length > 3) {
      _userAddressLineTwo = ValidationValues(error: null, value: value);
       isAddressValid = true;
    } else {
      _userAddressLineTwo = ValidationValues(error: 'Enter A Valid Address', value: null);
       isAddressValid = false;
    }
    notifyListeners();
  }

  void userEmailChanges(String value) {
    if (isEmailValid(value) == true) {
      _userEmail = ValidationValues(error: null, value: value);
      isEmailValidc = true;
    } else {
      _userEmail =
          ValidationValues(error: 'Invalid Email Address', value: null);
      isEmailValidc = false;
    }

    notifyListeners();
  }


    void userForgetEmailChanges(String value) {
    if (isEmailValid(value) == true) {
      _userEmail = ValidationValues(error: null, value: value);
      ispasswordEmailValidc = true;
    } else {
      _userEmail =
          ValidationValues(error: 'Invalid Email Address', value: null);
      ispasswordEmailValidc = false;
    }

    notifyListeners();
  }

  void confirmPassWWord(String value) {
    if (value != password) {
      _userConfirmPassword = ValidationValues(
          error: 'PassWord Should be Same As Above', value: null);
    } else {
      _userConfirmPassword = ValidationValues(error: null, value: value);
    }
    notifyListeners();
  }



   void userPassWordLoginChanges(String value) {
    String passwordDataUpparcase =
        r'^(?=.*[A-Z])'; // should contain at least one upper case
    String passwordDataLowerCase =
        r'^(?=.*?[a-z])'; // should contain at least one lower case
    String passwordDataNumber =
        r'^(?=.*?[0-9])'; // should contain at least one digit
    String passwordDataSpecialChar =
        r'^(?=.*?[!@#\$&*~])'; // should contain at least one Special character
    String passwordDataLength =
        r'^.{8,}$'; // Must be at least 8 characters in length

//(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}
    RegExp regExpUppercase = RegExp(passwordDataUpparcase);
    RegExp regExpLowercase = RegExp(passwordDataLowerCase);
    RegExp regExpNumber = RegExp(passwordDataNumber);
    RegExp regExpSpecialChar = RegExp(passwordDataSpecialChar);
    RegExp regExpLength = RegExp(passwordDataLength);
    // log(regExpUppercase.hasMatch(value).toString());
//log(valid.toString());
    // return regExp.hasMatch(password);

    //-------------- uppercase condetion ------------------

    if (!regExpUppercase.hasMatch(value)) {
      //uppercase condetion
      // _userName = ValidationValues(error: null, value: value);
      _userPassword = ValidationValues(
          error: 'should contain at least one upper case ', value: null);
      isPasswordValid = false;
    }
    //-------------- Lowecase condetion ------------------

    else if (!regExpLowercase.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'should contain at least one lower case', value: null);
      isPasswordValid = false;
    }

    //-------------- Number condetion ------------------

    else if (!regExpNumber.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'should contain at least one digit', value: null);
      isPasswordValid = false;
    }

    //-------------- Special Char condetion ------------------

    else if (!regExpSpecialChar.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'should contain at least one Special character', value: null);
      isPasswordValid = false;
    }

    //-------------- Length condetion ------------------

    else if (!regExpLength.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'Must be at least 8 characters in length', value: null);
      isPasswordValid = false;
    } else {
      _userPassword = ValidationValues(error: null, value: value);
      password = value;
      isPasswordValid = true;
    }

    notifyListeners();
  }

  void userPassWordChanges(String value) {
    String passwordDataUpparcase =
        r'^(?=.*[A-Z])'; // should contain at least one upper case
    String passwordDataLowerCase =
        r'^(?=.*?[a-z])'; // should contain at least one lower case
    String passwordDataNumber =
        r'^(?=.*?[0-9])'; // should contain at least one digit
    String passwordDataSpecialChar =
        r'^(?=.*?[!@#\$&*~])'; // should contain at least one Special character
    String passwordDataLength =
        r'^.{8,}$'; // Must be at least 8 characters in length

//(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}
    RegExp regExpUppercase = RegExp(passwordDataUpparcase);
    RegExp regExpLowercase = RegExp(passwordDataLowerCase);
    RegExp regExpNumber = RegExp(passwordDataNumber);
    RegExp regExpSpecialChar = RegExp(passwordDataSpecialChar);
    RegExp regExpLength = RegExp(passwordDataLength);
    // log(regExpUppercase.hasMatch(value).toString());
//log(valid.toString());
    // return regExp.hasMatch(password);

    //-------------- uppercase condetion ------------------

    if (!regExpUppercase.hasMatch(value)) {
      //uppercase condetion
      // _userName = ValidationValues(error: null, value: value);
      _userPassword = ValidationValues(
          error: 'should contain at least one upper case ', value: null);
      isPasswordValid = false;
    }
    //-------------- Lowecase condetion ------------------

    else if (!regExpLowercase.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'should contain at least one lower case', value: null);
      isPasswordValid = false;
    }

    //-------------- Number condetion ------------------

    else if (!regExpNumber.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'should contain at least one digit', value: null);
      isPasswordValid = false;
    }

    //-------------- Special Char condetion ------------------

    else if (!regExpSpecialChar.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'should contain at least one Special character', value: null);
      isPasswordValid = false;
    }

    //-------------- Length condetion ------------------

    else if (!regExpLength.hasMatch(value)) {
      _userPassword = ValidationValues(
          error: 'Must be at least 8 characters in length', value: null);
      isPasswordValid = false;
    } else {
      _userPassword = ValidationValues(error: null, value: value);
      password = value;
      isPasswordValid = true;
    }

    notifyListeners();
  }

  // void userAgeChanges(String value) {
  //   if (value.isNotEmpty && value.length < 3 && value != '0') {
  //     _userAge = ValidationValues(error: null, value: value);
  //   } else {
  //     _userAge = ValidationValues(error: 'In valid Format', value: null);
  //   }

  //   notifyListeners();
  // }

  void userPhoneChanges(String value) {
    if (value.length == 10) {
      _userPhone = ValidationValues(error: null, value: value);
       isAddressValid = true;
    } else {
      _userPhone =
          ValidationValues(error: 'Must Contains 10 Numbers', value: null);
           isAddressValid = false;
    }

    notifyListeners();
  }


    void userPincodeChanges(String value) {
    if (value.length >= 4) {
      _userPincode = ValidationValues(error: null, value: value);
       isAddressValid = true;
    } else {
      _userPincode = 
          ValidationValues(error: 'Minimum 4 Numbers', value: null); 
           isAddressValid = false;   
    }

    notifyListeners();
  }

  // void userDobChanges(String value) {
  //   try {
  //     DateTime.parse(value);
  //     _userDob = ValidationValues(error: null, value: value);
  //   } catch (e) {
  //     _userDob = ValidationValues(error: 'Invalid format', value: null);
  //   }

  //   notifyListeners();
  // }
}
