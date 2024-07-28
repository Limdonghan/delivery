import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Color? backgroundColor;
  final Widget child;
  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //입력을 받지 않으면은 흰색을 적용
      backgroundColor: backgroundColor ?? Colors.white,
      body: child,
    );
  }
}