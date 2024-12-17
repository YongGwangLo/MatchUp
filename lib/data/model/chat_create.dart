import 'package:cloud_firestore/cloud_firestore.dart';

class ChatCreateModel {
  final String address;
  final String category;
  final String createdUserId;
  final String createdUserName;
  final GeoPoint geoPoint;
  final String title;

  ChatCreateModel({
    required this.address,
    required this.category,
    required this.createdUserId,
    required this.createdUserName,
    required this.geoPoint,
    required this.title,
  });

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'category': category,
      'created_user_id': createdUserId,
      'created_user_name': createdUserName,
      'geo_point': geoPoint,
      'title': title,
    };
  }
}
