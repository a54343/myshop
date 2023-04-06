import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BankController extends GetxController {
  static BankController get instance => Get.find();

  //获取Form数据
  final cardnumber = TextEditingController();
  final expdate = TextEditingController();
  final holdname = TextEditingController();
  final cvv = TextEditingController();

  addCard(String cardnum, String expdate, String holdname, String cvv) async {
    await addCard(cardnum, expdate, holdname, cvv);
  }
}
