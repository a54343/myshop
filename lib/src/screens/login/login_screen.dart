import 'package:flutter/material.dart';
import 'package:soping/src/constants/image_strings.dart';
import 'package:soping/src/screens/login/login_form_widget.dart';
import 'package:soping/src/screens/login/login_header_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: "你好,欢迎使用",
                    subTitle: '黄河远上白云间，一片孤城万仞山。'),
                LoginFrom()
              ]),
        )),
      ),
    );
  }
}
