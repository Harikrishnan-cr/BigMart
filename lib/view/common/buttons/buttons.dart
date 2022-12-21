




import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/text_style.dart';
import 'package:flutter/cupertino.dart';



class CommonButtonTranspernt extends StatelessWidget {
  const CommonButtonTranspernt({Key? key, required this.height, required this.width, required this.iconWidth, required this.iconSize, required this.textFunction, required this.icon}) : super(key: key);
final double height;
final double width;
final double iconWidth;
final double iconSize;
final String textFunction;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: voiletColour,
            width: 1.6 
            )),
        child: Center(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [  
              //  SizedBox(
              // width: iconWidth,
              //  ),
              Icon(icon,size: iconSize,color: voiletColour,), 
               constWidth5,
              Text(
          textFunction.toString(),
          
          style: TextStyle(
                  fontWeight: FontWeight.w500, color: voiletColour, fontSize: 15),
        ),
              ],
            )),
      ),
    );
  }
}



class CommonButtonWithIconTranspernt extends StatelessWidget {
  const CommonButtonWithIconTranspernt({Key? key, required this.height, required this.width, required this.iconSize, required this.textFunction, required this.icon}) : super(key: key);
final double height;
final double width;

final double iconSize;
final String textFunction;
final IconData icon;
  @override
  Widget build(BuildContext context) {
    return  Padding(
       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: voiletColour,
            width: 1.6 
            )),
        child: Center(
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [  
              //  SizedBox(
              // width: iconWidth,
              //  ),
              Icon(icon,size: iconSize,color: voiletColour,), 
               constWidth5,
              Text(
          textFunction.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(
                  fontWeight: FontWeight.w500, color: voiletColour, fontSize: 15),
        ),
              ],
            )),
      ),
    );
  }
}

// class CommonButtonTranspernt extends StatelessWidget {
//   const CommonButtonTranspernt(
//       {Key? key, required this.height, this.titleText, this.colours,this.textColours,required this.textFontSize})
//       : super(key: key);

//   final double height;
//   final double textFontSize;
//   final Color? colours;
//   final Color? textColours;
//   final String? titleText;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Container(
//         width: double.infinity,
//         height: height,
//         decoration: BoxDecoration(
//             color: colours ?? greenColour,
//             borderRadius: BorderRadius.circular(12)),
//         child: Center(
//             child: Text(
//           titleText ?? 'SIGN IN', 
//           style: TextStyle(color:textColours,fontSize: textFontSize, fontWeight: FontWeight.w600),
//         )),
//       ),
//     );
//   }
// }