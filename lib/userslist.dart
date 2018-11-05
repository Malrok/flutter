import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterr/userdetail.dart';

class UsersList extends StatefulWidget {
  @override
  UsersListState createState() => new UsersListState();
}

class UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('Users\' list')),
        body: buildList());
  }

  Widget buildList() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').limit(10).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else {
          return new ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return new ListTile(
                  leading: new Image.network(
                      snapshot.data.documents[index]['picture'],
                      width: 64.0,
                      height: 64.0),
                  title: new Text(snapshot.data.documents[index]['first_name']),
                  subtitle:
                      new Text(snapshot.data.documents[index]['last_name']),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserDetail(id: snapshot.data.documents[index].documentID))
                    );
                  });
            },
            itemCount: snapshot.data.documents.length,
          );
        }
      },
    );
  }
}
