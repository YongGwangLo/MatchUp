import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/chat_page_view_model.dart';
import 'package:match_up/ui/chat/widgets/app_bar.dart';
import 'package:match_up/ui/chat/widgets/chat_page_body.dart';
import 'package:match_up/ui/chat/widgets/chat_page_information.dart';
import 'package:match_up/ui/chat/widgets/recive_message.dart';
import 'package:match_up/ui/chat/widgets/send_message.dart';

class ChatPage extends ConsumerWidget {
  ChatPage({
    super.key,
    required this.userId,
    required this.userImg,
    required this.userName,
  });

  final TextEditingController messageController = TextEditingController();
  final String userId;
  final String userImg;
  final String userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chats = ref.watch(chatViewModelProvider);
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          ChatPageInformation(),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return ChatPageBody(chat: chats[index]);
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: AppColors.lightGray,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.transparent,
                    child: Icon(
                      Icons.send,
                      color: AppColors.purple,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
