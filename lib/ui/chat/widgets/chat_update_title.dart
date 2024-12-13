import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

Widget chatUpdateTitle() {
  return SizedBox(
    height: 45,
    child: TextFormField(
      decoration: InputDecoration(
        hintText: '채팅방 제목을 입력해 주세요',
        hintStyle: TextStyle(color: AppColors.darkGray),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.lightGray,
            width: 1,
          ),
        ),
      ),
    ),
  );
}
