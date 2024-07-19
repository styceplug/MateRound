// import 'dart:async';
// import 'dart:io';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/services.dart';
//
// class DeviceInfoService {
//   Future<Map<String, dynamic>> getDeviceInfo() async {
//     final deviceInfo = DeviceInfoPlugin();
//     Map<String, dynamic> deviceData;
//
//     try {
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//         deviceData = _readAndroidBuildData(androidInfo);
//       } else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//         deviceData = _readIosDeviceInfo(iosInfo);
//       } else {
//         deviceData = {'Error': 'Platform not supported'};
//       }
//     } on PlatformException {
//       deviceData = {'Error': 'Failed to get platform version'};
//     }
//
//     return deviceData;
//   }
//
//   Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
//     return <String, dynamic>{
//       'model': "build.model",
//       'device': "android.device",
//       'androidId': "build.id",
//     };
//   }
//
//   Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
//     return <String, dynamic>{
//       'model': data.model,
//       'name': data.name,
//       'identifierForVendor': data.identifierForVendor,
//     };
//   }
// }
