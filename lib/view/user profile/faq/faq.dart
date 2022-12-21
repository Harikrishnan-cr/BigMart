import 'dart:developer';

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/settings/settings.dart';
import 'package:big_mart/view/common/App%20Bar/app_bar_common.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';

Widget accordionText({String? titleText, String? contentText}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: GFAccordion(
      margin: const EdgeInsets.all(3),
      titleBorderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      contentBorderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
      textStyle: const TextStyle(fontSize: 18),
      collapsedIcon: const Icon(Icons.add),
      expandedIcon: const Icon(Icons.remove),
      contentBackgroundColor: whiteColour,
      collapsedTitleBackgroundColor: whiteColour,
      expandedTitleBackgroundColor: whiteColour,
      title: titleText,
      contentChild: Text(
        '$contentText',
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      ),
      // content: 'Dukaan caters to a wide variety of sellers.Be Its a small grocery strore or a brand-abyone who want to sell their product/services online Dukaan is the perfect platform for you',
    ),
  );
}

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(subContent.length.toString());
    return Scaffold(
      appBar: appBarSecondaryCommon(context: context, titleText: 'FAQ'),
      body: ListView(children: [
        accordionText(titleText: headContent[0], contentText: subContent[0]),
        accordionText(titleText: headContent[1], contentText: subContent[1]),
        accordionText(titleText: headContent[2], contentText: subContent[2]),
        accordionText(titleText: headContent[3], contentText: subContent[3]),
        accordionText(titleText: headContent[4], contentText: subContent[4]),
        accordionText(titleText: headContent[5], contentText: subContent[5]),
        accordionText(titleText: headContent[6], contentText: subContent[6]),
        accordionText(titleText: headContent[7], contentText: subContent[7]),
        accordionText(titleText: headContent[8], contentText: subContent[8]),
        accordionText(titleText: headContent[9], contentText: subContent[9]),
        accordionText(titleText: headContent[10], contentText: subContent[10]),
        accordionText(titleText: headContent[11], contentText: subContent[11]),
      ]),
    );
  }
}
