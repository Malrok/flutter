import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterr/models/user.model.dart';

class UserDetailPage extends StatelessWidget {
  final String id;

  UserDetailPage({@required this.id});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('User\'s detail')),
        body: UserDetail(id: this.id));
  }
}

class UserDetail extends StatefulWidget {
  final String id;

  UserDetail({@required this.id});

  @override
  UserDetailState createState() => new UserDetailState(id: this.id);
}

class UserDetailState extends State<UserDetail> {
  final String id;

  final _formKey = GlobalKey<FormState>();

  User _user;

  UserDetailState({@required this.id});

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection('users')
        .document(this.id)
        .get()
        .then((userDoc) {
      User user = new User(userDoc);
      print(user.toString());
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.firstName,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.lastName,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.description,
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.email,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, we want to show a Snackbar
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
