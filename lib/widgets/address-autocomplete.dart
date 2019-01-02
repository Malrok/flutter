import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterr/models/address.model.dart';
import 'package:flutterr/services/geocoding.dart';

class AddressAutocomplete extends StatefulWidget {
  final GeoPoint location;

  AddressAutocomplete({this.location});

  @override
  AddressAutocompleteState createState() =>
      AddressAutocompleteState(location: this.location);
}

class AddressAutocompleteState extends State<AddressAutocomplete> {
  final GeoPoint location;

  Geocoding _geocoding = Geocoding();
  AddressModel _addressModel;

  AddressAutocompleteState({this.location});

  @override
  void initState() {
    super.initState();
    this
        ._geocoding
        .getFromCoordinates(this.location.latitude, this.location.longitude)
        .then((address) => setState(() {
              this._addressModel = address;
            }))
        .catchError((err) => print(err));
  }

  onTap() async {
//    Place place = await PluginGooglePlacePicker.showAutocomplete(PlaceAutocompleteMode.MODE_FULLSCREEN);
//    setState(() {
//      _addressModel.formattedAddress = place.address;
//    });
  }

  @override
  Widget build(BuildContext context) {
    if (_addressModel == null ||
        _addressModel.formattedAddress == null ||
        _addressModel.formattedAddress == "") {
      return GestureDetector(
          onTap: onTap,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Input address")));
    } else {
      return GestureDetector(
          onTap: onTap,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(_addressModel.formattedAddress)));
    }
  }
}
