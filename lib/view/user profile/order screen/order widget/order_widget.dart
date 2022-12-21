

import 'package:big_mart/controller/const/color/colours.dart';
import 'package:big_mart/controller/const/size/size.dart';
import 'package:big_mart/controller/const/style/Home%20Text/card_text_style.dart';
import 'package:big_mart/model/order%20model/order_model.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {
  OrderWidget({Key? key, required this.orderList}) : super(key: key);
  OrderModel orderList;

  late String dateOrdered;
  @override
  Widget build(BuildContext context) {
    final date = orderList.orderDate.toDate();
    dateOrdered = '${date.day}/${date.month}/${date.year}';

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 20,
      ),
      child: Container(
        width: 150,
        height: 170,  
        decoration: BoxDecoration(
          color: whiteColour,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FancyShimmerImage(
                    width: 100,
                    height: 75,
                    imageUrl: orderList.imgUrl,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      );
                    },
                  ),
                  constHeight10,
                  constHeight10,
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 210,
                          child: Text(
                            orderList.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: cardTextStyle(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 210,
                          child: Row(
                            children: [
                              Text(
                                'Price : ₹',
                                style: cardCurrencyTextStyle(),
                              ),
                              constWidth5,
                              Text(
                                (orderList.price * orderList.productQuantity)
                                    .toString(),
                                style: cardRsTextStyle(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              constHeight10,
              Text(
                'Qty : ${orderList.productQuantity} Pack',
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 15),
              ),
              constHeight10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Date : $dateOrdered',
                    style: cardTextStyle(),
                  ),
                  Text(
                    'Status : ${orderList.status}',
                    style: cardTextStyle(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
