import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/joined_user.dart';

class ChatRoom {
  final String id;
  final String address;
  final String category;
  final String createdUserId;
  final String createdUserName;
  final GeoPoint geoPoint;
  final List<JoinedUser> joinedUsers;
  final String title;

  ChatRoom(
      {required this.id,
      required this.address,
      required this.category,
      required this.createdUserId,
      required this.createdUserName,
      required this.geoPoint,
      required this.joinedUsers,
      required this.title});

  ChatRoom.fromJson(Map<String, dynamic> map)
      : this(
            id: map['id'],
            address: map['address'],
            category: map['category'],
            createdUserId: map['created_user_id'],
            createdUserName: map['created_user_name'],
            geoPoint: map['geo_point'],
            joinedUsers: List.from(map['joined_users']).map((e) {
              return JoinedUser.fromJson(e);
            }).toList(),
            title: map['title']);
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'category': category,
      'createdUserId': createdUserId,
      'createdUserName': createdUserName,
      'geoPoint': geoPoint,
      'joinedUsers': joinedUsers,
      'title': title,
    };
  }
}
