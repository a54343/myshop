import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../util/http/Userapi_util.dart';
import '../../util/localization/loadUser.dart';

class EditProfileController extends GetxController {
  static EditProfileController get instance => Get.find();
  //获取Form数据
  final nickname = TextEditingController();
  final address = TextEditingController();
  final email = TextEditingController();

  Future<void> updateUserForm(
      String nickname, String address, String email) async {
    await UpdateUser(nickname, address, email);
    saveUserNickName(nickname);
    saveUseraddress(address);
    saveUseremail(email);
  }
}
