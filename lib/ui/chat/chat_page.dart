import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/widgets/app_bar.dart';
import 'package:match_up/ui/chat/widgets/chat_page_information.dart';
import 'package:match_up/ui/chat/widgets/recive_message.dart';
import 'package:match_up/ui/chat/widgets/send_message.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        children: [
          ChatPageInformation(),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                ReciveMessage(
                  name: '김대성',
                  profile: 'https://picsum.photos/200/300',
                  showProfile: true,
                  message: '안녕하십니까?',
                  dateTime: DateTime.now(),
                ),
                SendMessage(
                  name: '목진성',
                  profile: 'https://picsum.photos/200/300',
                  showProfile: true,
                  message: '네 안녕하세요 !',
                  dateTime: DateTime.now(),
                ),
              ],
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
