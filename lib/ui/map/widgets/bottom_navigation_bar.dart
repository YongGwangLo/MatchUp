import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/map/map_page.dart';
import 'package:match_up/ui/mypage/mypage_page.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  HomeBottomNavigationBar({
    super.key,
  });

  final _index = 0;
  final _pageController = PageController();
  List<Widget> _pages = [
    MapPage(),
    MypagePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.purple,
      currentIndex: _index,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), label: '지도보기'),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person), label: '마이페이지'),
      ],
      onTap: (index) {
        _pageController.jumpToPage(index);
      },
    );
  }
}
