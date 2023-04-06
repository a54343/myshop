import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../util/http/Userapi_util.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final username = TextEditingController();
  final password = TextEditingController();
  final password2 = TextEditingController();
  final phonenumber = TextEditingController();

  RegisterUesr(
      String username, String password, String phonenumber, String password2) {
    if (username.isEmpty || password.isEmpty || phonenumber.isEmpty) {
      Get.snackbar("错误", "检查注册项是否填完");
    } else if (password != password2) {
      Get.snackbar("错误", "两次密码不一致");
    } else {
      RegisterU(username, password, phonenumber);
    }
  }
}
