import 'package:flutter/material.dart';
import 'package:match_up/constant/categories.dart';
import 'package:match_up/core/category_select.dart';

Widget chatUpdateCategory() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      categorySelect(Categories.footBall),
      categorySelect(Categories.basketBall),
      categorySelect(Categories.baseBall),
      categorySelect(Categories.tennis),
      categorySelect(Categories.pocketBall),
    ],
  );
}
