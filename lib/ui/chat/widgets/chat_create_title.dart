import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/chat_create_view_model.dart';

Widget chatCreateTitle() {
  return Consumer(
    builder: (context, ref, child) {
      return Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: AppColors.lightGray,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          onChanged: (value) {
            ref.read(chatTitleProvider.notifier).state = value;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12),
            border: InputBorder.none,
            hintText: '제목을 입력해주세요',
            hintStyle: TextStyle(
              fontSize: 16,
              color: AppColors.darkGray,
            ),
          ),
        ),
      );
    },
  );
}
