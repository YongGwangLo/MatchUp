import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String address;
  final String img;
  final String nickname;
  final List<String> createdRooms;
  final String name;
  final List<String> joinedRooms;
  final GeoPoint geoPoint;

  User({
    required this.id,
    required this.address,
    required this.img,
    required this.nickname,
    required this.createdRooms,
    required this.name,
    required this.joinedRooms,
    required this.geoPoint,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        geoPoint: json['geo_point'],
        address: json["address"],
        img: json["img"],
        nickname: json["nickname"],
        createdRooms: List<String>.from(json["created_rooms"].map((x) => x)),
        name: json["name"],
        joinedRooms: List<String>.from(json["joined_rooms"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "img": img,
        "nickname": nickname,
        "created_rooms": List<dynamic>.from(createdRooms.map((x) => x)),
        "name": name,
        "joined_rooms": List<dynamic>.from(joinedRooms.map((x) => x)),
        "geo_point": geoPoint
      };
}
