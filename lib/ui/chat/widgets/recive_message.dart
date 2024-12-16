import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';

class ReciveMessage extends StatelessWidget {
  final String name;
  final String profile;
  final bool showProfile;
  final String message;
  final DateTime dateTime;

  const ReciveMessage({
    super.key,
    required this.name,
    required this.profile,
    required this.showProfile,
    required this.message,
    required this.dateTime,
  });
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
          child: ClipOval(
            child: (showProfile == false || profile.isEmpty)
                ? Icon(Icons.person, size: 24)
                : Image.network(
                    profile,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.person, size: 24);
                    },
                  ),
          ),
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
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
                  message,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              dateTime.toIso8601String(),
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
