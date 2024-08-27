import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}


class _SliderScreenState extends State<SliderScreen> {


  @override
  Widget build(BuildContext context) {  // Add missing @override
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.only(left: 11 , right: 11),
            height: 180,
            width: double.infinity,
            child: AnotherCarousel(
              images: const [
                AssetImage("lib/images/1.jpg"),
                AssetImage("lib/images/2.jpg"),
                AssetImage("lib/images/3.jpg"),
                
              ],
              dotSize: 5 ,
              indicatorBgPadding: 5.0,
              boxFit: BoxFit.contain,
              borderRadius: true,
              radius: Radius.circular(20),
              dotBgColor: Colors.transparent,
              dotColor: Colors.grey,
              dotIncreasedColor: Colors.black,
              dotSpacing: 15,
              dotIncreaseSize: 1.5,
              
            ),
          )
      ],
    );
  }
}


