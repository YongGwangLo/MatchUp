import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/constant/categories.dart';
import 'package:match_up/ui/chat-submit/chat_submit_page.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 주변 지도보기',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatSubmitPage();
                  },
                ),
              );
            },
            child: Container(
              height: 50,
              width: 50,
              color: Colors.transparent,
              child: Icon(
                CupertinoIcons.add,
                color: AppColors.purple,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          NaverMap(),
          Positioned(
            left: 14,
            top: 15,
            child: Row(
              children: [
                Container(
                  width: 65,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(103),
                      color: AppColors.purple),
                  child: Center(
                    child: Text(
                      '전체',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                Container(
                  width: 52,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(103),
                    color: AppColors.white,
                  ),
                  child: Text(Categories.baseBall),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
