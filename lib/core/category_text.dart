import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

Widget categoryText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.black,
    ),
  );
}
