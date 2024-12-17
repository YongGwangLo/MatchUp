import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String id;
  final String address;
  final String category;
  final String createdUserId;
  final String createdUserName;
  final GeoPoint geoPoint;
  final String title;

  ChatRoom(
      {required this.id,
      required this.address,
      required this.category,
      required this.createdUserId,
      required this.createdUserName,
      required this.geoPoint,
      required this.title});

  ChatRoom.fromJson(Map<String, dynamic> map)
      : this(
            id: map['id'],
            address: map['address'],
            category: map['category'],
            createdUserId: map['created_user_id'],
            createdUserName: map['created_user_name'],
            geoPoint: map['geo_point'],
            title: map['title']);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'category': category,
      'createdUserId': createdUserId,
      'createdUserName': createdUserName,
      'geoPoint': geoPoint,
      'title': title,
    };
  }

  ChatRoom copyWith({
    String? id,
    String? address,
    String? category,
    String? createdUserId,
    String? createdUserName,
    GeoPoint? geoPoint,
    String? title,
  }) {
    return ChatRoom(
      id: id ?? this.id,
      address: address ?? this.address,
      category: category ?? this.category,
      createdUserId: createdUserId ?? this.createdUserId,
      createdUserName: createdUserName ?? this.createdUserName,
      geoPoint: geoPoint ?? this.geoPoint,
      title: title ?? this.title,
    );
  }
}
