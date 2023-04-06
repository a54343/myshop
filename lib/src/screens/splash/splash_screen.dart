import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soping/src/common_widgets/animation_design.dart';
import 'package:soping/src/controller/FadeInAnimationController.dart';
import 'package:soping/src/styles/colors_app.dart';

import '../../common_widgets/fade_in_animation_model.dart';
import '../../constants/image_strings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
              durationInMs: 1600,
              animatePosition: TAnimatePosition(
                  topAfter: 0, topBefore: -30, leftBefore: -30, leftAfter: 0),
              child: const Image(
                image: AssetImage(tSplashTopIcon),
              )),
          TFadeInAnimation(
              durationInMs: 1600,
              animatePosition: TAnimatePosition(
                  topAfter: 80, topBefore: 80, leftAfter: 30, leftBefore: -80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "轻商城",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    '毕业设计 \n理工学院物联网工程2班周鹏',
                    style: Theme.of(context).textTheme.headline5,
                  )
                ],
              )),
          TFadeInAnimation(
              durationInMs: 1600,
              animatePosition: TAnimatePosition(
                  bottomBefore: 0, bottomAfter: 100, leftBefore: 90),
              child: const Image(
                image: AssetImage(tSplashImage),
              )),
          TFadeInAnimation(
              durationInMs: 1600,
              animatePosition: TAnimatePosition(
                  leftAfter: 80,
                  leftBefore: -80,
                  bottomBefore: 40,
                  rightBefore: 40),
              child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: ColorsApp.orange200,
                  )))
        ],
      ),
    );
  }
}
