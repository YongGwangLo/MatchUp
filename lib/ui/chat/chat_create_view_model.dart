import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:match_up/data/model/chat_create.dart';

// 선택된 카테고리 상태 관리
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// 입력된 제목 상태 관리
final chatTitleProvider = StateProvider<String>((ref) => '');

// 현재 사용자 위치 정보 제공
final userLocationProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  final userDoc = await firestore.collection('users').doc(user?.uid).get();

  return {
    'address': userDoc.data()?['address'] ?? '',
    'geoPoint': userDoc.data()?['geo_point'] ?? const GeoPoint(0, 0),
  };
});

class ChatCreateViewModel extends StateNotifier<AsyncValue<void>> {
  ChatCreateViewModel() : super(const AsyncValue.data(null));

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> createChatRoom({
    required String category,
    required String title,
    required String address,
    required GeoPoint geoPoint,
  }) async {
    state = const AsyncValue.loading();

    try {
      final user = _auth.currentUser;
      final userDoc = await _firestore.collection('users').doc(user?.uid).get();

      final chatCreateModel = ChatCreateModel(
        address: address,
        category: category,
        createdUserId: user?.uid ?? '',
        createdUserName: userDoc.data()?['name'] ?? '',
        geoPoint: geoPoint,
        title: title,
      );

      await _firestore.collection('chat_rooms').add(chatCreateModel.toJson());
      state = const AsyncValue.data(null);
    } catch (error, stack) {
      state = AsyncValue.error(error, stack);
    }
  }
}

final chatCreateViewModelProvider =
    StateNotifierProvider<ChatCreateViewModel, AsyncValue<void>>(
  (ref) => ChatCreateViewModel(),
);
