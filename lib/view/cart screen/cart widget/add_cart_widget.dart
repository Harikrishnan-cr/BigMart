import 'package:big_mart/controller/const/color/colours.dart';
import 'package:flutter/cupertino.dart';

class AddItemsWidget extends StatelessWidget {
  const AddItemsWidget({
    Key? key,
    required this.subtraction,
  }) : super(key: key);

  final String subtraction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      width: 28,
      decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: greenColour)),
      child: Center(
          child: Text(
        subtraction,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: blackColour, fontSize: 22),
      )),
    );
  }
}






class AddItemsRevok extends StatelessWidget {
  const AddItemsRevok({
    Key? key,
    required this.subtraction,
  }) : super(key: key);

  final String subtraction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 29,
      width: 28,
      decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: greenColour)),
      child: Center(
          child: Text(
        'x',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: blackColour, fontSize: 22),
      )),
    );
  }
}
