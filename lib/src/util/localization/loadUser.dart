import 'package:shared_preferences/shared_preferences.dart';

void saveUserName(String userName) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user_name', userName);
}

Future<String?> readUserName() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('user_name');
}

void saveUserNickName(String nickName) async {
  final prefs = await SharedPreferences.getInstance();
  nickName ??= '未设置用户名';
  prefs.setString('user_nick_name', nickName);
}

Future<String?> readUserNickName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_nick_name');
}

void saveUseraddress(String address) async {
  final prefs = await SharedPreferences.getInstance();
  address ??= '未设置地址';
  prefs.setString('user_address', address);
}

Future<String?> readUseraddress() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('user_address');
}

void saveUseremail(String useremail) async {
  final prefs = await SharedPreferences.getInstance();
  useremail ??= '未设置邮箱';
  prefs.setString('user_email', useremail);
}

Future<String?> readUseremail() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('user_email');
}

void saveUserphone(String phonenumber) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('user_phone', phonenumber);
}

Future<String?> readUserphone() async {
  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('user_phone');
}

void cleanUser() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
