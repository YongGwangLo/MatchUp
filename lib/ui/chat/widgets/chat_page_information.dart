import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/ui/chat/chat_page_view_model.dart';

class ChatPageInformation extends ConsumerWidget {
  const ChatPageInformation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatInfoAsync = ref.watch(chatRoomInfoProvider);

    final chatInfo = chatInfoAsync.value ??
        {
          'category': '',
          'title': '',
          'created_user_name': '',
        };

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 23, 20, 15.5),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.lightGray,
              ),
            ),
            child: Center(
              child: Text(
                chatInfo['category'],
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(width: 18),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatInfo['title'],
                style: TextStyle(
                  color: AppColors.purple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '호스트: ${chatInfo['created_user_name']}',
                style: TextStyle(fontSize: 14, color: AppColors.black),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}
