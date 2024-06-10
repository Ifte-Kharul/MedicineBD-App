import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medicine_bd/constants/k_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Courosel extends StatefulWidget {
  const Courosel({super.key});

  @override
  State<Courosel> createState() => _CouroselState();
}

class _CouroselState extends State<Courosel> {
  var controller = PageController();
  int _current = 0;
  late Timer timer;
  final CarouselController _controller = CarouselController();
  @override
  var imgList = [
    "assets/images/1.png",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
  ];
  @override
  void initState() {
    timer = Timer.periodic(
      Duration(seconds: 5),
      (Timer timer) {
        if (_current < imgList.length) {
          setState(() {
            _current++;
          });

          controller.animateToPage(_current,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
        } else {
          setState(() {
            _current = -1;
          });
        }
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          // CarouselSlider(
          //   carouselController: _controller,
          //   items: [
          //     for (var img in imgList) Page(text: img),
          //   ],
          //   options: CarouselOptions(
          //     height: 250,
          //     viewportFraction: 1,
          //     onPageChanged: (index, _) {
          //       setState(() {
          //         // print(index);
          //         _current = index;
          //       });
          //     },
          //     // disableCenter: true,

          //     initialPage: 0,
          //     autoPlay: true,
          //     autoPlayInterval: const Duration(seconds: 3),
          //     enlargeCenterPage: true,
          //   ),
          // ),
          // AnimatedSmoothIndicator(
          //   activeIndex: _current,
          //   count: imgList.length,
          //   onDotClicked: (index) {
          //     _controller.animateToPage(
          //       index,
          //       duration: const Duration(milliseconds: 500),
          //       curve: Curves.ease,
          //     );
          //   },
          //   effect: JumpingDotEffect(
          //       offset: 10.0,
          //       dotHeight: 10,
          //       dotWidth: 10,
          //       jumpScale: .7,
          //       verticalOffset: 20,
          //       activeDotColor: Colors.red,
          //       dotColor: Colors.grey),
          // ),
          //Smmooth Slider
          SizedBox(
            height: 250,
            child: PageView(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
              children: [
                for (var img in imgList) Page(text: img),
              ],

              //   imgList.map((index) {
              //     int i = int.parse(index);
              //     print(i);
              //     return Page(text: imgList[i]);
              //   }).toList(),
              //
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.01,
            left: MediaQuery.of(context).size.width * 0.4,
            child: SmoothPageIndicator(
              onDotClicked: (index) {
                // print('Dot Clicked');
                setState(() {
                  _current = index;
                  // controller.dispose();
                });

                controller.animateToPage(_current,
                    curve: Curves.bounceInOut,
                    duration: Duration(milliseconds: 150));
              },
              controller: controller,
              count: imgList.length,
              effect: WormEffect(
                activeDotColor: kAppbarColor,
                dotColor: Colors.redAccent.withOpacity(0.35),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Page extends StatelessWidget {
  final String text;
  const Page({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 245,
      child: Image.asset(
        text,
        fit: BoxFit.cover,
      ),
    );
  }
}
