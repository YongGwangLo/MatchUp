import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/chat.dart';

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, List<Chat>>(
  (ref) => ChatViewModel(),
);

final currentUserProvider = FutureProvider<Map<String, String>>((ref) async {
  return {
    'userId': 'imsi',
    'userImg': 'https://picsum.photos/200/300',
    'userName': 'mmm',
  };
});

class ChatViewModel extends StateNotifier<List<Chat>> {
  ChatViewModel() : super([]) {
    _listenToChats();
  }

  final _firestore = FirebaseFirestore.instance;
  final String _chatRoomId = 'JGQel7KnD8aAYom4Zqbn';

  void _listenToChats() {
    try {
      _firestore
          .collection('chat_rooms')
          .doc(_chatRoomId)
          .collection('messages')
          .orderBy('time_stamp', descending: false)
          .snapshots()
          .listen(
        (snapshot) {
          if (!snapshot.metadata.isFromCache) {
            state = snapshot.docs
                .map((doc) => Chat.fromJson(doc.data(), doc.id))
                .toList()
                .reversed
                .toList();
          }
        },
        onError: (error) {
          // print('Error listening to messages: $error');
        },
      );
    } catch (e) {
      // print('Error in _listenToChats: $e');
    }
  }

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

      await _firestore
          .collection('chat_rooms')
          .doc(_chatRoomId)
          .collection('messages')
          .add(chat.toJson());
    } catch (e) {
      // print('Error sending message: $e');
    }
  }
}
