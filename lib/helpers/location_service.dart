// import 'package:geolocator/geolocator.dart';
// // import 'package:geocoding/geocoding.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class LocationService {
//   Future<String> getCurrentCountry() async {
//     try {
//       PermissionStatus status = await Permission.location.status;
//
//       if (status.isDenied) {
//         status = await Permission.location.request();
//       }
//
//       if (status.isGranted) {
//         Position position = await Geolocator.getCurrentPosition(
//             desiredAccuracy: LocationAccuracy.high);
//
//         List<Placemark> placemarks = await placemarkFromCoordinates(
//             position.latitude, position.longitude);
//
//         return placemarks.first.country ?? 'Unknown';
//       } else {
//         print('Location permission is denied');
//         return 'Unknown';
//       }
//     } catch (e) {
//       print(e);
//       return 'Unknown';
//     }
//   }
// }
