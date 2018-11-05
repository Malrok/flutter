import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {

  final String id;

  UserDetail({@required this.id});

  @override
  UserDetailState createState() => new UserDetailState(id: this.id);
}

class UserDetailState extends State<UserDetail> {

  final String id;

  UserDetailState({@required this.id});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: const Text('User\'s detail')
        ),
        body: buildList());
  }

  Widget buildList() {
    return new Text('$id');
  }
}
