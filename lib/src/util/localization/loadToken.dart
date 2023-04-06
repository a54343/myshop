import 'package:shared_preferences/shared_preferences.dart';

import '../http/Userapi_util.dart';

Future<String?> ReadToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  print("读入token$token");
  return token;
}

RemoveToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString("token");
  await logout(token!);
  prefs.clear();
}

Future<bool> checkToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token != null) {
    print('token存在');
  } else {
    print('token不存在');
  }
  return token != null;
}

writeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
  print("写入token$token");
}
