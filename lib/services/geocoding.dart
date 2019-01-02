import 'package:flutterr/models/address.model.dart';
import 'package:geocoder/geocoder.dart';

class Geocoding {
  Future<AddressModel> getFromAddress(String address) async {
    List<Address> addresses =
        await Geocoder.local.findAddressesFromQuery(address);
    Address first = addresses.first;
    return AddressModel.fromAddress(first);
  }

  Future<AddressModel> getFromCoordinates(
      double latitude, double longitude) async {
    final coordinates = new Coordinates(latitude, longitude);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    if (!addresses.isEmpty) {
    Address first = addresses.first;
    return AddressModel.fromAddress(first);
    } else {
      return AddressModel();
    }
  }
}
