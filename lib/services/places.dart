import 'dart:convert';

import 'package:flutterr/models/address.model.dart';
import 'package:http/http.dart' as http;

class Places {
  static const PLACES_URL =
      'https://maps.googleapis.com/maps/api/place/textsearch/json?query=QUERY&key=PLACES_API_KEY';

  static Future<List<AddressModel>> getPlaces(String query) async {
    List<AddressModel> addresses = List();

    final response = await http.get(PLACES_URL
        .replaceAll('QUERY', query)
        .replaceAll(
            'PLACES_API_KEY', 'AIzaSyCJhO9SPTit2418hkttbpn_KFxL-G3yyPM'));

    if (response.statusCode == 200) {
      List<dynamic> results = json.decode(response.body)['results'];
      results.forEach(
          (value) => addresses.add(AddressModel.fromJson(value)));
      return addresses;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load places');
    }
  }
}
