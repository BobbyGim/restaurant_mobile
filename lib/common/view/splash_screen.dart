import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/const/colors.dart';
import 'package:restaurant_mobile/common/const/data.dart';
import 'package:restaurant_mobile/common/const/dio.dart';
import 'package:restaurant_mobile/common/layout/default_layout.dart';
import 'package:restaurant_mobile/common/secure_storage/secure_storage.dart';
import 'package:restaurant_mobile/common/view/root_tap.dart';
import 'package:restaurant_mobile/user/view/login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    checkToken();
  }

  void checkToken() async {
    final storage = ref.read(secureStorageProvider);
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
