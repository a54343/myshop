import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:soping/src/util/localization/loadToken.dart';
import 'package:soping/src/util/localization/loadUser.dart';

import '../../styles/colors_app.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _nickname;
  String? _username;
  @override
  void initState() {
    super.initState();
    _getLocalInfo();
  }

  Future<void> _getLocalInfo() async {
    String? data = await readUserNickName();
    String? data2 = await readUserName();
    setState(() {
      _nickname = data;
      _username = data2;
    });
  }

  @override
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
                        onTap: () => Get.offNamed('Home'),
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
                                      Get.toNamed('EditProfile');
                                    },
                                    child: SvgPicture.asset(
                                      "assets/icons/compose-3.svg",
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: ElasticInUp(
                from: 1000,
                duration: const Duration(milliseconds: 1500),
                child: Center(
                  child: Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(160),
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(
                            'https://2333-1251992545.cos.ap-guangzhou.myqcloud.com/avt2.png',
                            width: 160,
                            height: 160,
                          ),
                        )),
                    Positioned(
                      bottom: 15,
                      right: 10,
                      child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(
                          'assets/icons/catt.svg',
                          color: ColorsApp.orange400,
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(1),
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
                          Text(
                            "昵称:$_nickname" ?? "加载中....",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              minimumSize: const Size(
                                double.minPositive,
                                double.minPositive,
                              ),
                              backgroundColor: isLight
                                  ? ColorsApp.white
                                  : ColorsApp.slate700,
                              foregroundColor: isLight
                                  ? ColorsApp.slate900
                                  : ColorsApp.slate100,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(999),
                              ),
                              textStyle: const TextStyle(fontSize: 12),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text('#$_username'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
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
                          ProfileMenuWidget(
                            title: "收货信息",
                            icon: 'assets/icons/paragraph-justify-2.svg',
                            onPress: () {},
                          ),
                          ProfileMenuWidget(
                            title: "我的订单",
                            icon: 'assets/icons/paragraph-justify-2.svg',
                            onPress: () {
                              Get.toNamed('OrderScreen');
                            },
                          ),
                          ProfileMenuWidget(
                            title: "付款信息",
                            icon: 'assets/icons/credit-card.svg',
                            onPress: () {
                              Get.toNamed('PayCard');
                            },
                          ),
                          ProfileMenuWidget(
                            title: "退出登陆",
                            icon: 'assets/icons/logout.svg',
                            onPress: () {
                              RemoveToken();
                              Get.offAllNamed('WelComeScreen');
                            },
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
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final String icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)),
        child: InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            icon,
            color: isLight ? ColorsApp.slate900 : ColorsApp.slate100,
            width: 30,
            height: 30,
          ),
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyText2?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: ColorsApp.white.withOpacity(0.1)),
              child: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/icons/chevron-right.svg',
                  color: isLight ? ColorsApp.slate900 : ColorsApp.slate100,
                  width: 30,
                  height: 30,
                ),
              ),
            )
          : null,
    );
  }
}
