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
    if (this.id != 'new') {
      Firestore.instance
          .collection('users')
          .document(this.id)
          .get()
          .then((userDoc) {
        User user = new User.fromSnapshot(userDoc);
        setState(() {
          _user = user;
        });
      });
    } else {
      User user = new User();
      setState(() {
        _user = user;
      });
    }
  }

  submit() {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (this.id != 'new') {
        Map<String, dynamic> data =
        this._user.toFirestoreObject(false);
        print(data);
        Firestore.instance
            .collection('users')
            .document(this.id)
            .setData(data, merge: true)
            .then((onValue) {
          Navigator.pop(context);
        });
      } else {
        Firestore.instance
            .collection('users')
            .add(this._user.toFirestoreObject(false))
            .then((onValue) {
          Navigator.pop(context);
        });
      }
    }
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
              onSaved: (text) {
                _user.firstName = text;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.lastName,
              onSaved: (text) {
                _user.lastName = text;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.description,
              onSaved: (text) {
                _user.description = text;
              },
            ),
            TextFormField(
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
              },
              initialValue: _user.email,
              onSaved: (text) {
                _user.email = text;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton(
                onPressed: this.submit,
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
