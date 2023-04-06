import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soping/src/models/Cartitme.dart';

import '../../constants/networkapi.dart';

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

Future<Map<String, dynamic>> gethomeproduct(String token) async {
  try {
    showLoading();
    print("调用 gethome 方法");
    final response =
        await dio.get(homeapi, options: Options(headers: {"token": token}));
    final Map<String, dynamic> data = Map<String, dynamic>.from(response.data);
    hideLoading();
    print(data);
    return data;
  } catch (e) {
    hideLoading();
    print(e);
  }
  return {};
}

void addCart(int id, String token) async {
  try {
    showLoading();
    final response = await dio.post(cartaddapi,
        options: Options(headers: {"token": token}),
        data: {"productid": id, "quantity": 1});
    hideLoading();
    Get.snackbar("${response.data['code']}", "${response.data['msg']}",
        snackPosition: SnackPosition.TOP);
  } catch (e) {
    hideLoading();
    print(e);
  }
}

void deleteCart(int id, String token) async {
  try {
    showLoading();
    final response = await dio.delete(cartdeleteapi,
        options: Options(
          headers: {"token": token, 'Content-Type': 'application/json'},
        ),
        data: id);
    hideLoading();
  } catch (e) {
    hideLoading();
    print(e);
  }
}

Future<List<CartItem>> getcartit(String token) async {
  try {
    showLoading();
    final response =
        await dio.get(cartgetapi, options: Options(headers: {"token": token}));
    if (response.data['code'] == 200) {
      hideLoading();
      final data = response.data['data'] as List;

      return data.map((json) => CartItem.fromJson(json)).toList();
    } else {
      hideLoading();
      throw Exception('Failed to load cart items');
    }
  } catch (e) {
    hideLoading();
    print(e);
    rethrow;
  }
}

Future<String?> createOrder(String token) async {
  try {
    showLoading();
    final response = await dio.get(ordercreateapi,
        options: Options(headers: {"token": token}));

    if (response.data['code'] == 200) {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
      return response.data['data'];
    } else {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
      return null;
    }
  } catch (e) {
    hideLoading();
    print(e);
  }
}

getorderforid(String token, String orderno) async {
  try {
    showLoading();
    final response = await dio.post(ordergetidapi,
        options: Options(headers: {"token": token}), data: orderno);

    if (response.data['code'] == 200) {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
      return response.data['data'];
    } else {
      hideLoading();
      throw Exception('Failed to load data');
    }
  } catch (e) {
    hideLoading();
    print(e);
  }
}

Future<List<dynamic>> getorder(String token) async {
  try {
    showLoading();
    final response = await dio.post(ordergetapi,
        options: Options(headers: {"token": token}));

    if (response.data['code'] == 200) {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
      return response.data['data'];
    } else {
      hideLoading();
      throw Exception('Failed to load data');
    }
  } catch (e) {
    hideLoading();
    print(e);
    rethrow;
  }
}

deleteorder(String token, String order) async {
  try {
    final response = await dio.post(orderdeleteapi,
        options: Options(headers: {"token": token}), data: order);
    if (response.data['code'] == 200) {
      hideLoading();
      Get.snackbar("${response.data['code']}", "${response.data['msg']}",
          snackPosition: SnackPosition.TOP);
    } else {
      hideLoading();
    }
  } catch (e) {
    hideLoading();
  }
}

updateorder(String token, String order) async {
  try {
    final response = await dio.post(orderupidapi,
        options: Options(headers: {"token": token}), data: order);

    hideLoading();
    Get.snackbar("${response.data['code']}", "${response.data['msg']}",
        snackPosition: SnackPosition.TOP);
  } catch (e) {
    hideLoading();
  }
}
