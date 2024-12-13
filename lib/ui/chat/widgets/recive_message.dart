import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

class ReciveMessage extends StatelessWidget {
  // final String profile;
  // final bool showProfile;
  // final String content;
  // final DateTime dateTime;

  // const ReciveMessage({
  //   super.key,
  //   required this.profile,
  //   required this.showProfile,
  //   required this.content,
  //   required this.dateTime,
  // });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                color: AppColors.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '안녕하십니까?',
                  style: TextStyle(
                    color: AppColors.black,
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
      ],
    );
  }
}
