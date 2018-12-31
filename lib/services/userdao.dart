import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterr/models/user.model.dart';

class UserDao {
  Future<User> getUserById(String id) async {
    var userDoc =
        await Firestore.instance.collection('users').document(id).get();
    return User.fromSnapshot(userDoc);
  }

  Future updateUser(String id, User user) {
    Map<String, dynamic> data = user.toFirestoreObject(false);
    return Firestore.instance
        .collection('users')
        .document(id)
        .setData(data, merge: true);
  }

  Future insertUser(User user) {
    return Firestore.instance
        .collection('users')
        .add(user.toFirestoreObject(false));
  }
}
