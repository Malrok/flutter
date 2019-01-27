import 'package:flutter/material.dart';
import 'package:flutterr/pages/userslist.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'translations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('fr', ''),
      ],
      title: 'Users\' list',
      home: UsersListPage(),
    );
  }
}
