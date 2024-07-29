/*
 * 앱에 처음 진입하면은 
 * 잠깐 동안 여러가지 정보들을 데이더들을 긇어오면서
 * 어떤 페이지로 보내줘야하는지 판단하는 페이지
 */

import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/const/data.dart';
import 'package:delivery/common/layout/default_layout.dart';
import 'package:delivery/common/view/root_tab.dart';
import 'package:delivery/user/view/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //deleteToken();
    
    checkToken();
  }

  void deleteToken() async {
    await storage.deleteAll();
  }

  void checkToken() async {

    //저장해놓은 키값 가져오기
    final refreshToken = await storage.read(key: REFRESS_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();
    try {
      final resp = await dio.post('http://$ip/auth/token',
      options: Options(
        headers: {'authorization' : 'Bearer $refreshToken',},
        ),
      );
      //토큰이 널이면 로그인 페이지로, 아니면 메인페이지로
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => RootTab(),
        ),
        (route) => false,
      );
    } catch (e) {
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
        (route) => false,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width /2,
              ),
              const SizedBox(height: 16.0,),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      )
    );
  }
}