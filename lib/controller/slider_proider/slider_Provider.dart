import 'package:big_mart/model/slier_add_model/slider_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class SliderProvider with ChangeNotifier {
  final List<SliderModel> _sliderImagesList = [];

  List<SliderModel> get getSliderImagesList {
    return _sliderImagesList;
  }

  Future<void> fetchSliderImageList() async { 
    await FirebaseFirestore.instance
        .collection('productsOffersAadmin')
        .orderBy('offerCreatedAt', descending: false)
        .get()
        .then((QuerySnapshot productsSnapshot) {
      for (var data in productsSnapshot.docs) {
        // log(data.get('title'));
        _sliderImagesList.insert(
            0,
            SliderModel(
                imgUrl: data.get('offerImgUrl'),
                offerCode: data.get('offerCode'),
                offerCreateDate: data.get('offerCreatedAt'), 
                offerId: data.get('offerId'),
                offerPerce: int.parse(data.get('offerPercentage'))) 
       

            );
      }
    });
  }
}
