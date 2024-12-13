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

// content
// "안녕하세요?"
// (문자열)


// time_stamp
// 2024년 12월 12일 오전 12시 35분 49초 UTC+9
// (타임스탬프)


// user_id
// "IX1v0eN1xAYJW58Y2g2S"
// (문자열)


// user_img
// "https://images.unsplash.com/photo-1732624579859-a20705f135e5?q=80&w=3687&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
// (문자열)


// user_name
// "김진용"