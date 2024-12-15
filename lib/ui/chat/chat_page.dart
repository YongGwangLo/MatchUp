import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/data/model/chat.dart';
import 'package:match_up/ui/chat/widgets/app_bar.dart';
import 'package:match_up/ui/chat/widgets/chat_page_body.dart';
import 'package:match_up/ui/chat/widgets/chat_page_information.dart';
import 'package:match_up/ui/chat/widgets/recive_message.dart';
import 'package:match_up/ui/chat/widgets/send_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          ChatPageInformation(),
          Divider(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: 10,
              separatorBuilder: (context, index) => SizedBox(width: 4),
              itemBuilder: (context, index) {
                return ChatPageBody(chat: Chat, isMe: true);
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
