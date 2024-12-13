import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

Widget button(String title, Color color) {
  return ElevatedButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(color),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),
    ),
  );
}
