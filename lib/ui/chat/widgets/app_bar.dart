import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

PreferredSizeWidget appBar(BuildContext context) {
  return AppBar(
    shape: Border(
      bottom: BorderSide(
        width: 1,
        color: AppColors.lightGray,
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/Chat_Update');
        },
        child: Container(
          width: 40,
          height: 40,
          color: Colors.transparent,
          child: Icon(Icons.settings_outlined, color: AppColors.purple),
        ),
      )
    ],
    title: Text(
      '경기도 남양주시 별내동',
      style: TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
