import 'package:actual/common/const/colors.dart';
import 'package:actual/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  onChanged: (value) {},
                ),
                SizedBox(height: 16.0,),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해 주세요',
                  obscureText: true,
                  onChanged: (value) {},
                ),
                SizedBox(height: 30.0,),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '로그인',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: PRIMARY_COLOR,
                  ),
                ),
                TextButton(
                  onPressed: () {},
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
