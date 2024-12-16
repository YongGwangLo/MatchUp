import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';

// chatRoomId 중앙에서 상태 관리
final chatRoomIdProvider = Provider<String>((ref) => 'wUC5E7wG5G2CMHd0HEuS');

final chatViewModelProvider = StateNotifierProvider<ChatViewModel, List<Chat>>(
  (ref) => ChatViewModel(ref.read(chatRoomIdProvider)),
);

final currentUserProvider = FutureProvider<Map<String, String>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  // 현재 로그인된 사용자 가져오기
  final currentUser = auth.currentUser;
  if (currentUser == null) {
    throw Exception('로그인된 사용자가 없습니다.');
  }

  // Firestore에서 사용자 정보 가져오기
  final userDoc =
      await firestore.collection('users').doc(currentUser.uid).get();
  if (!userDoc.exists) {
    throw Exception('사용자 정보를 찾을 수 없습니다.');
  }

  final userData = userDoc.data()!;
  return {
    'userId': currentUser.uid,
    'userImg': userData['image'] ?? '',
    'userName': userData['name'] ?? '',
  };
});

final chatRoomAddressProvider = FutureProvider<String>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final chatRoomId = ref.watch(chatRoomIdProvider);

  final chatRoomDoc =
      await firestore.collection('chat_rooms').doc(chatRoomId).get();

  if (!chatRoomDoc.exists) {
    throw Exception('채팅방을 찾을 수 없습니다.');
  }

  final data = chatRoomDoc.data()!;
  return data['address'] as String? ?? '주소 없음';
});

final chatRoomInfoProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final chatRoomId = ref.watch(chatRoomIdProvider);

  final chatRoomDoc =
      await firestore.collection('chat_rooms').doc(chatRoomId).get();

  if (!chatRoomDoc.exists) {
    throw Exception('채팅방을 찾을 수 없습니다.');
  }

  final data = chatRoomDoc.data()!;
  return {
    'category': data['category'] as String? ?? '',
    'title': data['title'] as String? ?? '',
    'created_user_name': data['created_user_name'] as String? ?? '',
  };
});

final chatRoomUsersProvider = FutureProvider<int>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final chatRoomId = ref.watch(chatRoomIdProvider);

  final chatRoomDoc =
      await firestore.collection('chat_rooms').doc(chatRoomId).get();

  if (!chatRoomDoc.exists) {
    throw Exception('채팅방을 찾을 수 없습니다.');
  }

  final data = chatRoomDoc.data()!;
  final List<dynamic> joinedUsers = data['joined_users'] ?? [];

  // 방장(created_user_name) + 참여자 수
  return 1 + joinedUsers.length;
});

class ChatViewModel extends StateNotifier<List<Chat>> {
  ChatViewModel(this._chatRoomId) : super([]) {
    _listenToChats();
  }

  final _firestore = FirebaseFirestore.instance;
  final String _chatRoomId;

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
          print('Error listening to messages: $error');
        },
      );
    } catch (error) {
      print('Error in _listenToChats: $error');
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
    } catch (error) {
      print('Error sending message: $error');
    }
  }
}
