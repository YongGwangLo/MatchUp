import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/user.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> fetchUser(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      return User.fromFirestore(doc);
    }
    return null;
  }

  Future<void> saveUser(User user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }
}
