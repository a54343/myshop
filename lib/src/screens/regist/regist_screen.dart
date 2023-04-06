import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/image_strings.dart';
import '../../controller/login/RegisterController.dart';
import '../login/login_header_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contorller = Get.put(RegisterController());
    final _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FormHeaderWidget(
                    image: tWelcomeScreenImage,
                    title: "注册成为新会员",
                    subTitle: '实惠好物天天有'),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: contorller.username,
                          decoration: const InputDecoration(
                              label: Text('用户名'),
                              prefixIcon: Icon(Icons.person),
                              hintText: '请出入用户名',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: contorller.phonenumber,
                          decoration: const InputDecoration(
                              label: Text('手机号'),
                              prefixIcon: Icon(Icons.phone),
                              hintText: '11位组成',
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: contorller.password,
                          decoration: const InputDecoration(
                              label: Text("密码"),
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              hintText: "****",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: contorller.password2,
                          decoration: const InputDecoration(
                              label: Text('重复密码'),
                              prefixIcon: Icon(Icons.lock_outline_rounded),
                              hintText: "****",
                              border: OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  contorller.RegisterUesr(
                                      contorller.username.text,
                                      contorller.password.text,
                                      contorller.phonenumber.text,
                                      contorller.password2.text);
                                },
                                child: const Text('注册')))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
