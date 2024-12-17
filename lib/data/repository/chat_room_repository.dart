import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/chat_rooms.dart';

class ChatRoomsRepository {
  final firesbaseFirestore = FirebaseFirestore.instance;
  Future<List<ChatRoom>> getChatRooms(String address) async {
    final result = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('address', isEqualTo: address)
        .get();
    return result.docs.map((e) {
      final newMap = {
        'id': e.id,
        ...e.data(),
      };
      final chatRoom = ChatRoom.fromJson(newMap);
      return chatRoom;
    }).toList();
  }

  Future<List<ChatRoom>> getCategory(String? address, String? category) async {
    final result = await FirebaseFirestore.instance
        .collection('chat_rooms')
        .where('address', isEqualTo: address)
        .where('category', isEqualTo: category)
        .get();
    return result.docs.map((e) {
      final newMap = {
        'id': e.id,
        ...e.data(),
      };
      final chatRoom = ChatRoom.fromJson(newMap);
      return chatRoom;
    }).toList();
  }
}
