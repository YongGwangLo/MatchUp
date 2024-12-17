import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel?> fetchUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc);
    }
    return null;
  }

  Future<void> saveUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'nickname': user.nickname,
      'address': user.address,
      'geo_point': user.geoPoint,
    });
  }
}
