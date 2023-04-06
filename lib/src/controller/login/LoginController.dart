import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../screens/on_boarding/on_boarding_screen.dart';
import '../../util/http/Userapi_util.dart';
import '../../util/localization/loadToken.dart';
import '../../util/localization/loadUser.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  //获取Form数据
  final username = TextEditingController();
  final password = TextEditingController();
  checkUser(String username, String password) {
    if (username.isEmpty || password.isEmpty) {}
  }

  void LoginUser(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar("错误", "用户名或密码为空", snackPosition: SnackPosition.TOP);
    } else {
      var result = await Login(username, password);
      if (result == 1) {
        var token = await ReadToken();
        Map data = await Details(token!);
        print(data);
        if (data['nick_name'] == null) {
          data['nick_name'] = '无名用户';
        }
        if (data['email'] == null) {
          data['email'] = '未设置邮箱';
        }
        if (data['address'] == null) {
          data['address'] = '未设置地址';
          Get.offAll(() => OnBoardingScreen());
        }

        saveUserName(data['data']['user_name']);
        saveUserNickName(data['data']['nick_name']);
        saveUseremail(data['data']['email']);
        saveUseraddress(data['data']['address']);
        saveUserphone(data['data']['phonenumber']);
        Get.offAllNamed("/Home");
      }
    }
  }
}
