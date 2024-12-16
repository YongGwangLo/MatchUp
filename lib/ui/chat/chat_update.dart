import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/core/button.dart';
import 'package:match_up/core/category_text.dart';
import 'package:match_up/ui/chat/widgets/chat_update_category.dart';
import 'package:match_up/ui/chat/widgets/chat_update_location.dart';
import 'package:match_up/ui/chat/widgets/chat_update_title.dart';

class ChatUpdate extends StatelessWidget {
  const ChatUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '채팅방 설정',
          style: TextStyle(
            fontSize: 20,
            color: AppColors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              categoryText('카테고리'),
              SizedBox(height: 10),
              chatUpdateCategory(),
              SizedBox(height: 20),
              categoryText('제목'),
              SizedBox(height: 10),
              chatUpdateTitle(),
              SizedBox(height: 20),
              categoryText('위치'),
              SizedBox(height: 10),
              chatUpdateLocation(),
              Spacer(),
              button(title: '수정하기', color: AppColors.purple),
              SizedBox(height: 10),
              button(title: '삭제하기', color: AppColors.onError),
            ],
          ),
        ),
      ),
    );
  }
}
