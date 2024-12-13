import 'package:flutter/material.dart';
import 'package:match_up/constant/colors.dart';
import 'package:match_up/ui/chat/widgets/chat_page_information.dart';
import 'package:match_up/ui/chat/widgets/recive_message.dart';
import 'package:match_up/ui/chat/widgets/send_message.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.lightGray,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/Chat_Update');
            },
            child: Container(
              width: 40,
              height: 40,
              color: Colors.transparent,
              child: Icon(Icons.settings_outlined, color: AppColors.purple),
            ),
          )
        ],
        title: Text(
          '경기도 남양주시 별내동',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          ChatPageInformation(),
          Divider(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                ReciveMessage(
                    // profile: '',
                    // showProfile: null,
                    // message: '',
                    // dateTime: null,
                    ),
                SendMessage(),
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
