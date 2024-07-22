import 'package:delivery/common/component/custom_text_from_field.dart';
import 'package:delivery/user/view/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    _App(),
  );
}

//_App "_"넣는 이유 Private변수 ,Private 값을 선언할 때
class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans', 
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}