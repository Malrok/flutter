import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterr/models/address.model.dart';
import 'package:flutterr/services/geocoding.dart';
import 'package:flutterr/widgets/address-autocomplete-modal.dart';

class AddressAutocomplete extends StatefulWidget {
  GeoPoint location;
  Function(GeoPoint) onChange;

  AddressAutocomplete({this.location, this.onChange});

  @override
  AddressAutocompleteState createState() =>
      AddressAutocompleteState(location: this.location);
}

class AddressAutocompleteState extends State<AddressAutocomplete> {
  GeoPoint location;
  Function(GeoPoint) onChange;

  Geocoding _geocoding = Geocoding();
  AddressModel _addressModel;

  AddressAutocompleteState({this.location, this.onChange});

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

  onTap(BuildContext context) async {
//    Place place = await PluginGooglePlacePicker.showAutocomplete(PlaceAutocompleteMode.MODE_FULLSCREEN);
//    setState(() {
//      _addressModel.formattedAddress = place.address;
//    });
    AddressModel address = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddressAutocompleteModal()));
    setState(() {
      _addressModel = address;
      location = GeoPoint(address.latitude, address.longitude);
    });
    widget.onChange(location);
  }

  @override
  Widget build(BuildContext context) {
    if (_addressModel == null ||
        _addressModel.formattedAddress == null ||
        _addressModel.formattedAddress == "") {
      return GestureDetector(
          onTap: () => onTap(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text("Input address")));
    } else {
      return GestureDetector(
          onTap: () => onTap(context),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(_addressModel.formattedAddress)));
    }
  }
}
