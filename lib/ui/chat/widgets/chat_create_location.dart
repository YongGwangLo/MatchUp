import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/chat_create_view_model.dart';
import 'package:match_up/ui/viewmodels/user_view_model.dart';

Widget chatCreateLocation() {
  return Consumer(
    builder: (context, ref, child) {
      final locationAsync = ref.watch(userLocationProvider);
      final userState = ref.watch(userViewModelProvider);

      return locationAsync.when(
        data: (location) => Container(
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
                userState.user!.address,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.purple,
                ),
              ),
            ],
          ),
        ),
        loading: () => Center(
          child: CircularProgressIndicator(
            color: AppColors.purple,
          ),
        ),
        error: (error, stack) => Center(
          child: Text(
            '위치 정보를 불러올 수 없습니다.',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
            ),
          ),
        ),
      );
    },
  );
}
