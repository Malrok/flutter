import 'package:flutter/material.dart';
import 'package:flutterr/models/user.model.dart';
import 'package:flutterr/services/image.dart';
import 'package:flutterr/services/userdao.dart';
import 'package:flutterr/widgets/address-autocomplete.dart';

import '../translations.dart';

class UserDetailPage extends StatelessWidget {
  final String id;
  final String photoTag;
  final String picturePath;

  UserDetailPage({@required this.id, this.picturePath, this.photoTag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(Translations.of(context).text('details_title'))),
        body: UserDetail(
            id: this.id,
            picturePath: this.picturePath,
            photoTag: this.photoTag));
  }
}

class UserDetail extends StatefulWidget {
  final String id;
  final String photoTag;
  final String picturePath;

  UserDetail({@required this.id, this.picturePath, this.photoTag});

  @override
  UserDetailState createState() => UserDetailState(
      id: this.id, picturePath: this.picturePath, photoTag: this.photoTag);
}

class UserDetailState extends State<UserDetail> {
  final String id;
  String picturePath = '';
  String photoTag = '';

  final _formKey = GlobalKey<FormState>();

  ImageService _imageService = ImageService();
  UserDao _dao = UserDao();
  UserModel _user;

  UserDetailState({@required this.id, this.picturePath, this.photoTag}) {
    if (this.photoTag == null) {
      this.photoTag = '';
    }
  }

  @override
  void initState() {
    super.initState();
    if (this.id != 'new') {
      this._dao.getUserById(this.id).then((user) {
        setState(() {
          _user = user;
          picturePath = user.picture;
        });
      });
    } else {
      UserModel user = new UserModel();
      setState(() {
        _user = user;
        picturePath = user.picture;
      });
    }
  }

  Future pickImage() async {
    String url = await this._imageService.getImage();
    if (url != null) {
      setState(() {
        picturePath = url;
      });
    }
  }

  submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      this._user.picture = this.picturePath;
      if (this.id != 'new') {
        this
            ._dao
            .updateUser(this.id, this._user)
            .then((res) => Navigator.pop(context));
      } else {
        this._dao.insertUser(this._user).then((res) => Navigator.pop(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                    onTap: pickImage,
                    child: Hero(
                        tag: 'photo' + this.photoTag,
                        child: Material(
                            child: Image.network(picturePath,
                                width: 64.0, height: 64.0)))),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  decoration: InputDecoration(
                      labelText:
                          Translations.of(context).text('details_first_name')),
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
                  decoration: InputDecoration(
                      labelText:
                          Translations.of(context).text('details_last_name')),
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
                  decoration: InputDecoration(
                      labelText:
                          Translations.of(context).text('details_description')),
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
                  decoration: InputDecoration(
                      labelText:
                          Translations.of(context).text('details_email')),
                  initialValue: _user.email,
                  onSaved: (text) {
                    _user.email = text;
                  },
                ),
                AddressAutocomplete(
                  location: _user.address,
                  onChange: (geopoint) => _user.address = geopoint,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: this.submit,
                    child: Text(Translations.of(context).text('submit')),
                  ),
                ),
              ],
            ),
          ));
    }
  }
}
