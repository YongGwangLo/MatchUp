import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String nickname;
  final String img;
  final GeoPoint geoPoint;
  final List<String> createdRooms;
  final List<String> joinedRooms;
  final String address;

  User({
    required this.uid,
    required this.name,
    required this.nickname,
    required this.img,
    required this.geoPoint,
    required this.createdRooms,
    required this.joinedRooms,
    required this.address,
  });

  factory User.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return User(
      uid: doc.id,
      name: data['name'],
      nickname: data['nickname'],
      img: data['img'],
      geoPoint: data['geo_point'],
      createdRooms: List<String>.from(data['created_rooms']),
      joinedRooms: List<String>.from(data['joined_rooms']),
      address: data['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'nickname': nickname,
      'img': img,
      'geo_point': geoPoint,
      'created_rooms': createdRooms,
      'joined_rooms': joinedRooms,
      'address': address,
    };
  }
}
