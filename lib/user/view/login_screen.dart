import 'dart:convert';
import 'dart:io';

import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:actual/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/const/data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    //final storage = FlutterSecureStorage();

    final dio = Dio();
    // localhsot

    return DefaultLayout(
      child: SingleChildScrollView(
        // 텍스트필드 다른곳을 눌렀을때 키보드가 사라진다.
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
                SizedBox(height: 16.0,),
                _SubTitle(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: (MediaQuery.of(context).size.width / 3) * 2,
                  //height: MediaQuery.of(context).size.height / 3,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해 주세요',
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    username = value;
                  },
                ),
                SizedBox(height: 16.0,),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해 주세요',
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: 30.0,),
                ElevatedButton(
                  onPressed: () async {
                    // ID:비밀번호 'test@codefactory.ai:testtest'
                    final rawString = '$username:$password';

                    Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    String token = stringToBase64.encode(rawString);

                    final resp = await dio.post('http://$ip/auth/login',
                    options: Options(
                      headers: {
                        'authorization' : 'Basic $token',
                      },
                    ));

                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => RootTab()),
                    );
                  },
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    //await storage.read(key: key);
                    //final refreshToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTY4MDg0MTc3NiwiZXhwIjoxNjgwOTI4MTc2fQ.Ft3EmlpyWMz0ENhnijF_QAHl1Xn9TzwPxIXDYcGZbqw';

                  },
                  style: TextButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                  child: Text(
                    '회원가입',
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

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('환영합니다!',
        style: TextStyle(
            fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black));
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인해 주세요!\n오늘도 성공적인 주문이 되길:)',
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
