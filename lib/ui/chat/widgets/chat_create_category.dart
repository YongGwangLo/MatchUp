import 'package:flutter/material.dart';
import 'package:match_up/constant/categories.dart';
import 'package:match_up/core/category_select.dart';

Widget chatUpdateCategory() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        categorySelect(Categories.footBall),
        SizedBox(width: 10),
        categorySelect(Categories.basketBall),
        SizedBox(width: 10),
        categorySelect(Categories.baseBall),
        SizedBox(width: 10),
        categorySelect(Categories.tennis),
        SizedBox(width: 10),
        categorySelect(Categories.pocketBall),
      ],
    ),
  );
}
