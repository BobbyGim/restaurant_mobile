import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/common/const/colors.dart';
import 'package:untitled1/common/const/data.dart';
import 'package:untitled1/common/const/dio.dart';
import 'package:untitled1/common/const/storage.dart';
import 'package:untitled1/common/layout/default_layout.dart';
import 'package:untitled1/common/view/root_tap.dart';
import 'package:untitled1/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    try {
      final res = await dio.post(
        "$ip/auth/token",
        options: Options(headers: {"authorization": "Bearer $refreshToken"}),
      );

      await storage.write(
        key: ACCESS_TOKEN_KEY,
        value: res.data['accessToken'],
      );

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => RootTap()),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Image.asset(
              'asset/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 16),

            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
