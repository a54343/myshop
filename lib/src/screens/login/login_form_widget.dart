import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/login/LoginController.dart';

class LoginFrom extends StatefulWidget {
  const LoginFrom({super.key});

  @override
  State<LoginFrom> createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final controller = Get.put(LoginController());
  final _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  void _hideorshowpass() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.username,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: "用户名",
                  hintText: "请输入用户名",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: controller.password,
              focusNode: _passwordFocusNode,
              obscureText: _isObscure,
              autofocus: true,
              maxLength: 15,
              maxLines: 1,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  labelText: "密码",
                  hintText: "****",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _hideorshowpass();
                    },
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
                alignment: Alignment.centerRight,
                child:
                    TextButton(onPressed: () {}, child: const Text("忘记密码？"))),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      controller.LoginUser(
                          controller.username.text, controller.password.text);
                    },
                    child: const Text("登陆")))
          ],
        ),
      ),
    );
  }
}
