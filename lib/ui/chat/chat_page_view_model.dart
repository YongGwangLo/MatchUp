import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/chat.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, List<Chat>>(
  (ref) => ChatViewModel(),
);

class ChatViewModel extends StateNotifier<List<Chat>> {
  ChatViewModel() : super([]) {
    _listenToChats();
  }

  final _firestore = FirebaseFirestore.instance;

  // 실시간 채팅
  void _listenToChats() {
    _firestore.collection('chats').orderBy('time_stamp').snapshots().listen(
      (snapshot) {
        state = snapshot.docs
            .map((doc) => Chat.fromJson(doc.data(), doc.id))
            .toList();
      },
    );
  }

  // 사용자 정보 조회 및 새 채팅 메시지 전송
  Future<void> sendMessage(
      {required String content, required String userId}) async {
    try {
      // Firestore에서 사용자 정보 가져오기
      final userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        final chat = Chat(
          content: content,
          timeStamp: DateTime.now(),
          userId: userId,
          userImg: userData['user_img'],
          userName: userData['user_name'],
        );

        await _firestore.collection('chats').add(chat.toJson());
      }
    } catch (e) {
      print('$e');
    }
  }
}
