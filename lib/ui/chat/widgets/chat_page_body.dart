import 'package:flutter/material.dart';
import 'package:match_up/data/model/chat.dart';
import 'package:match_up/ui/chat/widgets/send_message.dart';
import 'package:match_up/ui/chat/widgets/recive_message.dart';

class ChatPageBody extends StatelessWidget {
  final Chat chat;
  final bool isMe;

  const ChatPageBody({
    super.key,
    required this.chat,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isMe)
            SendMessage(
              name: chat.userName,
              profile: chat.userImg,
              showProfile: true,
              message: chat.content,
              dateTime: chat.timeStamp,
            )
          else
            ReciveMessage(
              name: chat.userName,
              profile: chat.userImg,
              showProfile: true,
              message: chat.content,
              dateTime: chat.timeStamp,
            ),
        ],
      ),
    );
  }
}
