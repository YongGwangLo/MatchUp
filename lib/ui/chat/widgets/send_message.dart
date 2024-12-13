import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

class SendMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '김대성',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.purple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '안녕하십니까?',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '2024년 12월 11일 (수) 12:22',
              style: TextStyle(
                color: AppColors.darkGray,
                fontSize: 12,
              ),
            ),
          ],
        ),
        SizedBox(width: 4),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.lightGray,
          ),
          child: ClipRRect(
            child: Icon(Icons.person, size: 24),
          ),
        ),
      ],
    );
  }
}
