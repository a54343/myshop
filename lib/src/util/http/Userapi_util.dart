import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/networkapi.dart';
import '../localization/loadToken.dart';

final loading = RxBool(false);
final dio = new Dio();

// 显示loading
showLoading() {
  loading.value = true;
  Get.dialog(const Center(child: CircularProgressIndicator()),
      barrierDismissible: false);
}

// 隐藏loading
hideLoading() {
  if (loading.value) {
    loading.value = false;
    Get.back();
  }
}

// ignore: non_constant_identifier_names
Future<int> Login(String username, String password) async {
  try {
    showLoading();
    final response = await dio.post(Loginapi,
        data: {"userName": "${username}", "password": "${password}"});
    print(response);
    if (response.data['code'] == 200) {
      await writeToken(response.data['data']['token']);
      print("loginguserN${response.data['data']['Name']}");
      hideLoading();
      return 1;
    } else {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
      return 0;
    }
  } catch (e) {
    hideLoading();
    print(e);
    return 0;
  }
}

Future<Map<String, dynamic>> Details(String token) async {
  try {
    showLoading();
    print("调用 Details 方法");
    final response =
        await dio.get(detailsapi, options: Options(headers: {"token": token}));
    final Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
    hideLoading();
    return data;
  } catch (e) {
    hideLoading();
    print(e);
  }
  return {};
}

TestToken(String token) async {
  final response =
      await dio.get(Testapi, options: Options(headers: {"token": token}));
  if (response.data['code'] == 200) {
    return true;
  } else {
    return false;
  }
}

refreshToken(String token) async {
  if (await TestToken(token)) {
    print("调用refresh方法");
    final response =
        await dio.get(refreshapi, options: Options(headers: {"token": token}));
    writeToken(response.data['data']);
    return true;
  } else {
    print("token过期");
    return false;
  }
}

RegisterU(String username, String password, String phonenumber) async {
  try {
    showLoading();
    final response = await dio.post(Registerapi, data: {
      "userName": "${username}",
      "password": "${password}",
      "phonenumber": "${phonenumber}"
    });
    if (response.data['code'] == 200) {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
      Get.toNamed("/LoginScreen");
    } else {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
    }
  } catch (e) {
    Get.snackbar("error", "$e", snackPosition: SnackPosition.TOP);
  }
}

UpdateUser(String nickname, String address, String email) async {
  try {
    showLoading();
    String? token = await ReadToken();
    final response = await dio.put(updateapi,
        data: {"nickName": nickname, "address": address, "email": email},
        options: Options(headers: {"token": token}));
    hideLoading();
    print(response);
    Get.snackbar("${response.data['code']}", "${response.data['msg']}");
  } catch (e) {
    hideLoading();
    Get.snackbar("error", "$e", snackPosition: SnackPosition.TOP);
  }
}

logout(String token) async {
  try {
    showLoading();
    final response =
        await dio.get(logoutsapi, options: Options(headers: {"token": token}));
    hideLoading();
    Get.snackbar("${response.data['code']}", "${response.data['msg']}");
  } catch (e) {
    hideLoading();
    Get.snackbar("error", "$e", snackPosition: SnackPosition.TOP);
  }
}

getcard(String token) async {
  try {
    showLoading();
    final response =
        await dio.get(getcardapi, options: Options(headers: {"token": token}));
    final Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
    hideLoading();
    return data['data'];
  } catch (e) {
    hideLoading();
    print(e);
  }
  return {};
}

UpdateCard(String cardnum, String expdate, String holdname, String cvv) async {
  try {
    showLoading();
    String? token = await ReadToken();
    final response = await dio.post(addcardapi,
        data: {
          "cardnum": cardnum,
          "expdate": expdate,
          "holdname": holdname,
          "cvv": cvv
        },
        options: Options(headers: {"token": token}));
    hideLoading();
    print("22${response.data}");
    Get.snackbar("${response.data['code']}", "${response.data['msg']}");
  } catch (e) {
    hideLoading();
    Get.snackbar("error", "$e", snackPosition: SnackPosition.TOP);
  }
}
