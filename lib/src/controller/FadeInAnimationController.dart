import 'package:get/get.dart';

import '../util/http/Userapi_util.dart';
import '../util/localization/loadToken.dart';
import '../util/localization/loadUser.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();
  RxBool animate = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animate.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    if (await checkToken()) {
      String? token = await ReadToken();
      print(token);
      var result = await refreshToken(token!);
      print("result:$result");

      if (result) {
        //UserController userController = Get.put(UserController());
        var data = await Details(token);
        print("splashdata$data");
        if (data['data']['nick_name'] == null) {
          data['data']['nick_name'] = '无名用户';
        }
        if (data['data']['email'] == null) {
          data['data']['email'] = '未设置邮箱';
        }
        if (data['data']['address'] == null) {
          data['data']['address'] = '未设置地址';
        }
        saveUserName(data['data']['user_name']);
        saveUserNickName(data['data']['nick_name']);
        saveUseraddress(data['data']['address']);
        saveUserphone(data['data']['phonenumber']);
        saveUseremail(data['data']['email']);
        Get.offAllNamed('/Home');
      } else {
        print("test");
        Get.offAllNamed("/WelComeScreen");
      }
    } else {
      Get.offAllNamed("/WelComeScreen");
    }
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
  }
}
