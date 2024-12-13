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

  Chat.fromJson(Map<String, dynamic> map)
      : this(
          content: map['content'],
          timeStamp: DateTime.parse(map['time_stamp']),
          userId: map['user_id'],
          userImg: map['user_img'],
          userName: map['user_name'],
        );
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'time_stamp': timeStamp.toIso8601String(),
      'user_id': userId,
      'user_img': userImg,
      'user_name': userName,
    };
  }
}
