import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String description;
  String email;
  String picture;
  GeoPoint address;

  User(DocumentSnapshot snapDoc) {
    Map<String, dynamic> data = snapDoc.data;
    this.id = snapDoc.documentID;
    this.firstName = data['first_name'];
    this.lastName = data['last_name'];
    this.description = data['description'];
    this.email = data['email'];
    this.picture = data['picture'];
//    this.address = data['address'];
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, description: $description, email: $email, picture: $picture, address: $address}';
  }

}