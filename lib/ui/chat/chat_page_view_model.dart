import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/chat.dart';

// 채팅 데이터 상태를 관리하는 ViewModel
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
    _firestore
        .collection('messages')
        .orderBy('time_stamp', descending: false)
        .snapshots()
        .listen(
      (snapshot) {
        state = snapshot.docs
            .map((doc) => Chat.fromJson(doc.data(), doc.id))
            .toList();
      },
    );
  }

  // 새 채팅 메시지를 Firestore에 전송
  Future<void> sendMessage({
    required String content,
    required String userId,
    required String userImg,
    required String userName,
  }) async {
    try {
      final chat = Chat(
        content: content,
        timeStamp: DateTime.now(),
        userId: userId,
        userImg: userImg,
        userName: userName,
      );

      await _firestore.collection('messages').add(chat.toJson());
    } catch (e) {
      print('$e');
    }
  }
}
