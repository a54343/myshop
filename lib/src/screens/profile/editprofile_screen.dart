import 'package:animate_do/animate_do.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:city_pickers/modal/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soping/src/util/localization/loadUser.dart';

import '../../controller/User/EditProfile_contorller.dart';
import '../../styles/colors_app.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final addressController = TextEditingController();
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() async {
    // 从本地存储中读取数据，并将对应的文本编辑框的内容设置为读取的数据
    String? savedAddress = await readUseraddress(); // 从本地存储中读取地址信息
    String? savedNickname = await readUserNickName(); // 从本地存储中读取昵称信息
    String? savedEmail = await readUseremail(); // 从本地存储中读取邮箱信息
    setState(() {
      addressController.text = savedAddress ?? '';
      nicknameController.text = savedNickname ?? '';
      emailController.text = savedEmail ?? '';
    });
  }

  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:
                isLight ? ColorsApp.neutral100 : ColorsApp.slate900,
            snap: true,
            floating: true,
            elevation: 1,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    ElasticIn(
                      duration: const Duration(milliseconds: 1500),
                      child: GestureDetector(
                        onTap: () => Get.offNamed("ProfileScreen"),
                        child: SvgPicture.asset(
                          "assets/icons/arrow_alt_left.svg",
                          height: 16,
                          color:
                              isLight ? ColorsApp.slate900 : ColorsApp.slate100,
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElasticIn(
                      duration: const Duration(milliseconds: 1500),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: isLight ? ColorsApp.white : ColorsApp.slate700,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(999),
                                child: Ink(
                                  height: 32,
                                  width: 32,
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      editProfileController.updateUserForm(
                                          nicknameController.text,
                                          addressController.text,
                                          emailController.text);
                                      Get.back();
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/cloud-upload.svg",
                                      color: isLight
                                          ? ColorsApp.slate900
                                          : ColorsApp.slate100,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          //--头部结束
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElasticInUp(
                    from: 1000,
                    delay: const Duration(milliseconds: 100),
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              labelText: "昵称",
                              hintText: "请输入昵称",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            controller: nicknameController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: "Email",
                                hintText: "请输入邮箱",
                                border: OutlineInputBorder()),
                            controller: emailController,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: "地址",
                                hintText: "点击选择地址",
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: () async {
                                      Result? result =
                                          await CityPickers.showCityPicker(
                                              context: context);
                                      if (result != null) {
                                        addressController.text =
                                            '${result.provinceName} ${result.cityName} ${result.areaName}';
                                      }
                                    },
                                    icon: const Icon(Icons.edit))),
                            controller: addressController,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<Result?> getResult() async {
    Result? result = await CityPickers.showCityPicker(context: context);
    print('result $result');

    return result;
  }
}
