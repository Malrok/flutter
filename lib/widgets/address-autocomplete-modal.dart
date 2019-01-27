import 'package:flutter/material.dart';
import 'package:flutterr/models/address.model.dart';
import 'package:flutterr/services/places.dart';
import 'package:flutterr/translations.dart';

class AddressAutocompleteModal extends StatefulWidget {
  AddressAutocompleteModal();

  @override
  AddressAutocompleteModalState createState() =>
      AddressAutocompleteModalState();
}

class AddressAutocompleteModalState extends State<AddressAutocompleteModal> {
  List<AddressModel> _addresses;

  AddressAutocompleteModalState();

  @override
  void initState() {
    super.initState();
  }

  loadPlaces(String text) async {
    List<AddressModel> result = await Places.getPlaces(text);
    setState(() {
      _addresses = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_addresses == null) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                  Translations.of(context).text('address_autcomplete_title'))),
          body: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        child: TextField(
                      onChanged: loadPlaces,
                      decoration: InputDecoration(
                          labelText: Translations.of(context)
                              .text('address_autcomplete_hint')),
                    ))
                  ])));
    } else {
      return Scaffold(
          appBar: AppBar(
              title: Text(
                  Translations.of(context).text('address_autcomplete_title'))),
          body: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Material(
                        child: TextField(
                      onChanged: loadPlaces,
                      decoration: InputDecoration(
                          labelText: Translations.of(context)
                              .text('address_autcomplete_hint')),
                    )),
                    Expanded(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: new Text(_addresses[index].formattedAddress),
                        );
                      },
                      itemCount: _addresses.length,
                    ))
                  ])));
    }
  }
}
