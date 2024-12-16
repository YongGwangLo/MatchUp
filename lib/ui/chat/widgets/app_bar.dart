import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/ui/chat/chat_page_view_model.dart';

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
          Navigator.pushNamed(context, '/chat_update');
        },
        child: Container(
          width: 40,
          height: 40,
          color: Colors.transparent,
          child: Icon(Icons.settings_outlined, color: AppColors.purple),
        ),
      )
    ],
    title: Consumer(
      builder: (context, ref, child) {
        final addressAsync = ref.watch(chatRoomAddressProvider);
        final address = addressAsync.value ?? '';

        return Text(
          address,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );
}
