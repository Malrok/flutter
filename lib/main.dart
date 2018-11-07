import 'package:flutter/material.dart';
import 'package:flutterr/pages/userslist.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users\' list',
      home: UsersListPage(),
    );
  }
}
