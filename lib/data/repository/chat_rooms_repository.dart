import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/chat_rooms.dart';

class ChatRoomsRepository {
  final firesbaseFirestore = FirebaseFirestore.instance;
  Future<ChatRooms> getChatRoom(String uid) async {
    final result = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(uid)
        .get();

    final newMap = {
      'id': result.id,
      ...result.data()!,
    };
    final chatRoom = ChatRooms.fromJson(newMap);
    return chatRoom;
  }
}
