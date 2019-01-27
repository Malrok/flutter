import 'package:geocoder/geocoder.dart';

class AddressModel {
  double latitude = 0;
  double longitude = 0;
  String formattedAddress = "";
  String postalCode = "";
  String city = "";
  String country = "";

  AddressModel();

  AddressModel.fromAddress(Address address)
      : latitude = address.coordinates.latitude,
        longitude = address.coordinates.longitude,
        formattedAddress = address.addressLine,
        postalCode = address.postalCode,
        city = address.locality,
        country = address.countryName;

  AddressModel.fromJson(Map<String, dynamic> json)
      : latitude = json['geometry']['location']['lat'],
        longitude = json['geometry']['location']['lng'],
        formattedAddress = json['formatted_address'];
}
