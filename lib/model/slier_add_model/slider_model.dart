import 'package:cloud_firestore/cloud_firestore.dart';

class SliderModel {
  String imgUrl;
  int offerPerce;
  String offerCode;
  String offerId;
  Timestamp offerCreateDate; 

  SliderModel(
      {required this.imgUrl,
      required this.offerCode,
      required this.offerCreateDate,
      required this.offerId,
      required this.offerPerce});
}
