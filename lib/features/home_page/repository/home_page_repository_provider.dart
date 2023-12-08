import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:here/models/city_model.dart';

final HomePageRepositoryProvider = Provider(
  (ref) => HomePageRepository(),
);

class HomePageRepository {
  late CityModel _city;

  set cityData(CityModel cityData) {
    _city = cityData;
  }

  Future<void> setCity() async {
    Position position = await _determinePosition();
    // process and get output

    CityModel c = CityModel(
      name: 'DBC',
      countryName: 'IND',
      info: "Hello ",
      famousFor: 'HAHA',
      places: [],
    );

    cityData = c;
  }

  CityModel getCurrentCity() {
    return _city;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
