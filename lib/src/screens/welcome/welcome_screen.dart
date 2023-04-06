import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soping/src/common_widgets/animation_design.dart';
import 'package:soping/src/constants/image_strings.dart';
import 'package:soping/src/controller/FadeInAnimationController.dart';
import 'package:soping/src/styles/colors_app.dart';

import '../../common_widgets/fade_in_animation_model.dart';

class WelComeScreen extends StatelessWidget {
  const WelComeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    final bool isLight = Theme.of(context).brightness == Brightness.light;

    return ThemeSwitchingArea(
      child: Scaffold(
        backgroundColor: isLight ? ColorsApp.neutral100 : ColorsApp.slate900,
        body: Stack(
          children: [
            TFadeInAnimation(
                durationInMs: 1200,
                animatePosition: TAnimatePosition(
                    bottomAfter: 0,
                    bottomBefore: -100,
                    topAfter: 0,
                    topBefore: 0,
                    leftBefore: 0,
                    leftAfter: 0,
                    rightBefore: 0,
                    rightAfter: 0),
                child: Container(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Hero(
                          tag: "welcome-image-tag",
                          child: Image(
                            image: AssetImage(tWelcomeScreenImage),
                          )),
                      Column(
                        children: const [
                          Text(
                            "你好，欢迎使用",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "黄河远上白云间，一片孤城万仞山。",
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: OutlinedButton(
                            onPressed: () => Get.toNamed('/LoginScreen'),
                            child: const Text("登陆"),
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: ElevatedButton(
                            onPressed: () => Get.toNamed('/RegisterScreen'),
                            child: const Text("注册"),
                          )),
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
