import 'package:delivery/common/const/colors.dart';
import 'package:delivery/common/layout/default_layout.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'AppTitle : Delivery',
      child: Scaffold(
        body: Center(child: Text('Root Tab'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              this.index = index;
            });
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: '홈'),
            BottomNavigationBarItem(icon: Icon(Icons.fastfood_outlined),label: '음식'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined),label: '주문'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline),label: '프로필'),
          ],
        ),
      ),
    );
  }
}