import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:soping/src/styles/colors_app.dart';

import '../constants/image_strings.dart';
import '../constants/text_strings.dart';
import '../models/model_on_boarding.dart';
import '../screens/on_boarding/on_boarding_page_widget.dart';
import 'User/UserController.dart';

class OnBoardingController extends GetxController {
  final controller = LiquidController();
  final usercontroller = Get.put(UserController());
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingPage(
      model: OnboardingModel(
        image: tOnBoardingImage1,
        title: tOnBoardingTitle1,
        subTitle: tOnBoardingsubTitle1,
        counterText: tOnBoardingcounter,
        bgColor: ColorsApp.orange200,
      ),
    ),
    OnBoardingPage(
      model: OnboardingModel(
        image: tOnBoardingImage2,
        title: tOnBoardingTitle2,
        subTitle: tOnBoardingsubTitle2,
        counterText: tOnBoardingcounter2,
        bgColor: ColorsApp.orange300,
      ),
    ),
    OnBoardingPage(
      model: OnboardingModel(
        image: tOnBoardingImage3,
        title: tOnBoardingTitle3,
        subTitle: tOnBoardingsubTitle3,
        counterText: tOnBoardingcounter3,
        bgColor: ColorsApp.orange400,
      ),
    ),
  ];
  onPageChangeCallback(int activePageIndex) =>
      currentPage.value = activePageIndex;
  animateToNextSiide() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }

  skip() async {
    Get.offAllNamed('/Home');
  }
}
