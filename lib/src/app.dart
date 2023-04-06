import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soping/src/screens/cart/cart_screen.dart';
import 'package:soping/src/screens/home/home_screen.dart';
import 'package:soping/src/screens/login/login_screen.dart';
import 'package:soping/src/screens/order/order_screen.dart';
import 'package:soping/src/screens/order/orderdetil_screen.dart';
import 'package:soping/src/screens/paycard/card.dart';
import 'package:soping/src/screens/profile/editprofile_screen.dart';
import 'package:soping/src/screens/profile/profile_screen.dart';
import 'package:soping/src/screens/regist/regist_screen.dart';
import 'package:soping/src/screens/splash/splash_screen.dart';
import 'package:soping/src/screens/welcome/welcome_screen.dart';
import 'package:soping/src/styles/themes_app.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: ThemesApp.lightTheme,
      builder: (context, theme) => GetMaterialApp(
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => const MyApp()),
          GetPage(name: "/Home", page: () => const HomeScreen()),
          GetPage(name: '/WelComeScreen', page: () => const WelComeScreen()),
          GetPage(name: '/LoginScreen', page: () => const LoginScreen()),
          GetPage(name: '/RegisterScreen', page: () => const RegisterScreen()),
          GetPage(name: '/ProfileScreen', page: () => const ProfileScreen()),
          GetPage(name: '/EditProfile', page: () => const EditProfile()),
          GetPage(name: '/CartScreen', page: () => const CartScreen()),
          GetPage(
              name: '/OrderDetailScreen',
              page: () => const OrderDetailScreen()),
          GetPage(name: '/OrderScreen', page: () => const OrderScreen()),
          GetPage(name: '/PayCard', page: () => const PayCard()),
        ],
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: const SplashScreen(),
      ),
    );
  }
}
