import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id = '';
  String firstName = '';
  String lastName = '';
  String description = '';
  String email = '';
  String picture = '';
  GeoPoint address;

  User() {}

  User.fromSnapshot(DocumentSnapshot snapDoc) {
    if (snapDoc != null) {
      Map<String, dynamic> data = snapDoc.data;
      this.id = snapDoc.documentID;
      this.firstName = data['first_name'];
      this.lastName = data['last_name'];
      this.description = data['description'];
      this.email = data['email'];
      this.picture = data['picture'];
//    this.address = data['address'];
    }
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, description: $description, email: $email, picture: $picture, address: $address}';
  }

  Map<String, dynamic> toFirestoreObject(bool addId) {
    Map<String, dynamic> result = new Map();
    result['first_name'] = this.firstName;
    result['last_name'] = this.lastName;
    result['description'] = this.description;
    result['email'] = this.email;
    result['picture'] = this.picture;
    if (addId) {
      result['id'] = this.id;
    }
    return result;
  }
}
