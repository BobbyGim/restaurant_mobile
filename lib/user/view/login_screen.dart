import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_mobile/common/components/custom_text_form_input.dart';
import 'package:restaurant_mobile/common/const/colors.dart';
import 'package:restaurant_mobile/common/const/data.dart';
import 'package:restaurant_mobile/common/const/dio.dart';
import 'package:restaurant_mobile/common/layout/default_layout.dart';
import 'package:restaurant_mobile/common/secure_storage/secure_storage.dart';
import 'package:restaurant_mobile/common/view/root_tap.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Title(),
                const SizedBox(height: 16),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: MediaQuery.of(context).size.width / 3 * 2,
                  fit: BoxFit.cover,
                ),
                CustomTextFormInput(
                  hintText: '이메일을 입력해주세요.',
                  onChanged: (String value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                CustomTextFormInput(
                  hintText: '비밀번호를 입력해주세요.',
                  obscureText: true,
                  onChanged: (String value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final rawStirng = "$username:$password";
                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    final token = stringToBase64.encode(rawStirng);
                    final storage = ref.read(secureStorageProvider);

                    final res = await dio.post(
                      "$ip/auth/login",
                      options: Options(
                        headers: {"authorization": "Basic $token"},
                      ),
                    );

                    await storage.write(
                      key: ACCESS_TOKEN_KEY,
                      value: res.data['accessToken'],
                    );

                    await storage.write(
                      key: REFRESH_TOKEN_KEY,
                      value: res.data['refreshToken'],
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const RootTap()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text('로그인', style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    foregroundColor: PRIMARY_COLOR,
                  ),
                  child: Text('회원가입', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다.",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
