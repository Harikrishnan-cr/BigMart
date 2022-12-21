import 'package:big_mart/controller/slider_proider/slider_Provider.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
        // Provider.of<ProductProvider>(context, listen: false);
        // int listLength = productsProvider.getProductList.length;
    return Scaffold(
      body: Consumer<SliderProvider>(
        builder: (context, sliderProvider, _) {
          return Swiper(
            itemBuilder: (BuildContext context, int index) {

              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FancyShimmerImage(
                    imageUrl:
                        sliderProvider.getSliderImagesList[index].imgUrl,    
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(  
                                image: imageProvider, fit: BoxFit.fill)),
                      );
                    },
                  ));  
            },
            itemCount: sliderProvider.getSliderImagesList.length,
            autoplay: true,
            pagination: const SwiperPagination(
                margin: EdgeInsets.all(2), builder: SwiperPagination.rect),
          );
        }
      ),
    );
  }
}
