import 'package:geolocator/geolocator.dart';

//TODO: UPDATE the code more test permission
class Geo_Location {
  //double latitude;
  //Location();
  static Future<dynamic> checkPermissionLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        print('Location permissions are permanently denied, we cannot request permissions.');
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }else{
     // if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      double latitude = position.latitude;
      double longitude = position.longitude;
      return position;
    } catch (e) {
      print("Error here in location.dart" + e);
    }
  }
}
