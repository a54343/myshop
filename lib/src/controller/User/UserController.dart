import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../../util/localization/loadToken.dart';
import '../../util/localization/loadUser.dart';

class UserController extends GetxController {
  var isLoading = true.obs;
  var user = Rx<User>(User());

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void updateUser(User newUser) {
    user.value = newUser;
  }

  void clearUser() {
    user(User());
  }

  void fetchUser() async {
    try {
      isLoading(true);
      var token = await ReadToken();
      String? username = await readUserName();
      String? nickname = await readUserNickName();
      String? email = await readUseremail();
      String? address = await readUseraddress();

      Map<String, dynamic> data = {
        'user_name': username,
        'nick_name': nickname,
        'email': email,
        'address': address
      };
      print("本地数据$data");
      user(User.fromJson(data));
    } finally {
      isLoading(false);
    }
  }
}
