import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

Widget categorySelect(String icon) {
  return GestureDetector(
    onTap: () {
      print('select');
    },
    child: Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.lightGray),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: Text(
        icon,
        style: TextStyle(
          fontSize: 24,
        ),
      )),
    ),
  );
}
