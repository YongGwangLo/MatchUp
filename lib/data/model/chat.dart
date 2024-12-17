import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String content;
  DateTime timeStamp;
  String userId;
  String userImg;
  String userName;

  Chat({
    required this.content,
    required this.timeStamp,
    required this.userId,
    required this.userImg,
    required this.userName,
  });

  Chat.fromJson(Map<String, dynamic> map, String id)
      : this(
          content: map['content'] as String,
          timeStamp: map['timestamp'] is String
              ? DateTime.parse(map['timestamp'])
              : (map['timestamp'] as Timestamp).toDate(),
          userId: map['user_id'] as String,
          userImg: map['user_img'] as String,
          userName: map['user_name'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'timestamp': timeStamp.toIso8601String(),
      'user_id': userId,
      'user_img': userImg,
      'user_name': userName,
    };
  }
}
