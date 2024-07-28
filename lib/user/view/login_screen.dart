import 'dart:convert';
import 'dart:io';

import 'package:delivery/common/component/custom_text_from_field.dart';
import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/layout/default_layout.dart';
import 'package:delivery/common/view/root_tab.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:delivery/common/const/data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String userPw = '';

  @override
  Widget build(BuildContext context) {
    final storage = FlutterSecureStorage();
    final dio = Dio();
    ///final simulatorIp = '127.0.0.1:3000';
    final ipAddress = '192.168.1.8:3000';  //갤럭시 IP
    //final ipAddress2 = '192.168.1.5:3000';  //갤럭시 IP

    final ip = Platform.isAndroid ? ipAddress : '연결실패';

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
                  SizedBox(height: 16.0),
                  _SubTitle(),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width /3 * 2,
                  ),
                  CustomTextFromField(
                    hintText: '이메일 !',
                    onChanged: (value) {
                      username = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  CustomTextFromField(
                    hintText: '비밀번호 !',
                    onChanged: (value) {
                      userPw = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      print('들어왔니?');
                      //ID:PW  $username:$userPw
                      final rawString = 'test@codefactory.ai:testtest';

                      Codec<String, String> stringToBase64 = utf8.fuse(base64);

                      String token = stringToBase64.encode(rawString);

                      print("base64 : $token");
                      print("ip : $ip");
                    
                    final resp = await dio.post('http://$ip/auth/login',
                      options: Options(
                        headers: {
                          'authorization' : 'Basic $token',
                        },
                      ),
                    );
                    final refreshToken = resp.data['refreshToken'];
                    final accessToken = resp.data['accessToken'];

                    await storage.write(key: REFRESS_TOKEN_KEY, value: refreshToken);
                    await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                    print('refresh : $refreshToken');
                    print('access : $accessToken');
                    
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RootTab(),
                      )
                    );
                  }, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white,
                    ),
                  child: Text('로그인')
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () async {
                      final refreshToken = REFRESS_TOKEN_KEY;
                      final resp = await dio.post('http://$ip/auth/token',
                      options: Options(
                        headers: {
                          'authorization' : 'Bearer $refreshToken',
                        },
                      ),
                    );
                    print(resp.data);
                  }, 
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Text('회원가입')
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
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다.',
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      )
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인 해주세요! \n 오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}