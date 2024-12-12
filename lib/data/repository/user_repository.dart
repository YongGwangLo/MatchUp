import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_up/data/model/user.dart';

class UserRepository {
  final firebaseFirestore = FirebaseFirestore.instance;
  Future<User> getUser(String uid) async {
    final result =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    // final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    // final CollectionReference collection = fireStore.collection('users');
    // final DocumentReference fireGet = collection.doc('IX1v0eN1xAYJW58Y2g2S');
    // final DocumentSnapshot<Object?> result1 = await fireGet.get();
    final newMap = {
      'id': result.id,
      ...result.data()!,
    };

    final user = User.fromJson(newMap);
    return user;
    // newMap은 id를 첨부한 새로운 맵 documentSnapShot 내부의 data 내에는 id가 없어서
    //id={
    // name :'김진용'
    // address : '서울시 서초구 잠원동'
    //}
    // final data = result.data();
    // final geoPoint = data!['geo_point'] as GeoPoint;
    // print(geoPoint.latitude);
    // print(data['geo_point'].longitude);
    // // data!.remove('geo_point');
    // // print(jsonEncode(data));
  }
}
