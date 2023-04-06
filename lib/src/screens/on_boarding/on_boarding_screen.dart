import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:soping/src/styles/colors_app.dart';

import '../../controller/OnBoardingController.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final obcontroller = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obcontroller.pages,
            liquidController: obcontroller.controller,
            onPageChangeCallback: obcontroller.onPageChangeCallback,
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
              bottom: 60.0,
              child: OutlinedButton(
                  onPressed: () => obcontroller.animateToNextSiide(),
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.black26),
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20),
                      onPrimary: Colors.white),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: const BoxDecoration(
                        color: ColorsApp.slate900, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward_ios),
                  ))),
          Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () => obcontroller.skip(),
                child: const Text(
                  "跳过",
                  style: TextStyle(color: Colors.grey),
                ),
              )),
          Obx(
            () => Positioned(
              bottom: 10,
              child: AnimatedSmoothIndicator(
                count: 3,
                activeIndex: obcontroller.currentPage.value,
                effect: const WormEffect(
                    activeDotColor: Color(0xff272727), dotHeight: 5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
