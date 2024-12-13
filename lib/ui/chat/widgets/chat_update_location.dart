import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

Widget chatUpdateLocation() {
  return Container(
    height: 45,
    decoration: BoxDecoration(
      border: Border.all(
        width: 1,
        color: AppColors.lightGray,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        SizedBox(width: 12),
        Icon(
          Icons.gps_fixed,
          color: AppColors.purple,
        ),
        SizedBox(width: 12),
        Text(
          '경기도 남양주시 별내동',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.purple,
          ),
        ),
      ],
    ),
  );
}
