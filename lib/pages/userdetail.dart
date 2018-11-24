import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterr/models/user.model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDetailPage extends StatelessWidget {
  final String id;
  final String photoTag;
  final String picturePath;

  UserDetailPage({@required this.id, this.picturePath, this.photoTag});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('User\'s detail')),
        body: UserDetail(id: this.id, picturePath: this.picturePath, photoTag: this.photoTag));
  }
}

class UserDetail extends StatefulWidget {
  final String id;
  final String photoTag;
  final String picturePath;

  UserDetail({@required this.id, this.picturePath, this.photoTag});

  @override
  UserDetailState createState() =>
      new UserDetailState(id: this.id, picturePath: this.picturePath, photoTag: this.photoTag);
}

class UserDetailState extends State<UserDetail> {
  final String id;
  String picturePath = '';
  String photoTag = '';

  final _formKey = GlobalKey<FormState>();
  FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://cross-platform-test.appspot.com');
  StorageReference ref;

  User _user = new User();

  UserDetailState({@required this.id, this.picturePath, this.photoTag}) {
    ref = storage.ref().child('avatars');
    if (this.photoTag == null) {
      this.photoTag = '';
    }
  }

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
          picturePath = user.picture;
        });
      });
    } else {
      User user = new User();
      setState(() {
        _user = user;
        picturePath = user.picture;
      });
    }
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);

//    _user.picture = image.path;
    print(image.path.substring(image.path.lastIndexOf('/') + 1));

    StorageReference pictureRef = ref.child('tmp_' + image.path.substring(image.path.lastIndexOf('/') + 1));

    StorageUploadTask uploadTask = pictureRef.putFile(image);
    await uploadTask.onComplete;
    String url = await pictureRef.getDownloadURL();
    setState(() {
      picturePath = url;
    });
  }

  submit() {
    // Validate will return true if the form is valid, or false if
    // the form is invalid.
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      this._user.picture = this.picturePath;
      if (this.id != 'new') {
        Map<String, dynamic> data = this._user.toFirestoreObject(false);
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
//    if (_user == null) {
//      return Center(child: CircularProgressIndicator());
//    } else {
      return new Container(
          padding: new EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: getImage,
                    child: new Hero(
                        tag: 'photo' + this.photoTag,
                        child: Material(
                            child: new Image.network(picturePath,
                                width: 64.0, height: 64.0)))),
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
          ));
//    }
  }
}
