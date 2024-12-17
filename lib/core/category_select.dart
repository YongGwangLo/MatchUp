import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/chat_create_view_model.dart';

Widget categorySelect(String text) {
  return Consumer(
    builder: (context, ref, child) {
      final selectedCategory = ref.watch(selectedCategoryProvider);
      final isSelected = selectedCategory == text;

      return GestureDetector(
        onTap: () {
          ref.read(selectedCategoryProvider.notifier).state = text;
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppColors.purple : AppColors.lightGray,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
      );
    },
  );
}
