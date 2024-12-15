import 'package:flutter/material.dart';
import 'package:match_up/data/model/chat.dart';

class ChatPageBody extends StatelessWidget {
  final Chat chat;

  const ChatPageBody({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(chat.userImg),
            radius: 20,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chat.userName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white70),
                ),
                SizedBox(height: 5),
                Text(
                  chat.content,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 5),
                Text(
                  chat.timeStamp.toLocal().toString(),
                  style: TextStyle(fontSize: 10, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
