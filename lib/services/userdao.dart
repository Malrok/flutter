import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterr/models/user.model.dart';

class UserDao {
  Future<UserModel> getUserById(String id) async {
    var userDoc =
        await Firestore.instance.collection('users').document(id).get();
    return UserModel.fromSnapshot(userDoc);
  }

  Future updateUser(String id, UserModel user) {
    Map<String, dynamic> data = user.toFirestoreObject(false);
    return Firestore.instance
        .collection('users')
        .document(id)
        .setData(data, merge: true);
  }

  Future insertUser(UserModel user) {
    return Firestore.instance
        .collection('users')
        .add(user.toFirestoreObject(false));
  }
}
