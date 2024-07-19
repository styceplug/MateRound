import 'package:mate_round/api/api_client.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> uploadImage(File image, int userId) async {
    var data = await _apiClient.sendImageRequest(
      "https://materound.com/app/api/v1/profile/upload_image.php",
      image,
      userId,
    );

    return data;
  }

  Future<Map<String, dynamic>> submitUserInfo({
    required int userId,
    required String firstName,
    required String lastName,
    required String username,
    required String bio,
    required DateTime birthday,
    required String gender,
    required String height,
    required String hairColor,
  }) async {
    Map<String, String> userInfo = {
      'userId': userId.toString(),
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'bio': bio,
      'birthday': birthday.toIso8601String(),
      'gender': gender,
      'height': height,
      'hairColor': hairColor,
    };

    try {
      Map<String, dynamic> response = await _apiClient.submitUserInfo(userInfo);

      if (response.containsKey('error') && !response['error']) {

        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setInt('userId', userId);
        await prefs.setString('firstName', firstName);
        await prefs.setString('lastName', lastName);
        await prefs.setInt('isPro', 0);
        await prefs.setInt('proType', 0);

        return {
          'error': false,
          'message': 'Information submitted successfully'
        };
      } else {
        return {
          'error': true,
          'message': response['message'] ?? 'An error occurred'
        };
      }
    } catch (e) {
      return {'error': true, 'message': 'Failed to submit information: $e'};
    }
  }

  Future<Map<String, dynamic>> sendOtp(int userId) async {
    try {
      Map<String, dynamic> response = await _apiClient.sendOtpRequest(userId);

      if (response.containsKey('error') && !response['error']) {
        return {'error': false, 'message': 'OTP sent successfully'};
      } else {
        return {
          'error': true,
          'message': response['message'] ?? 'An error occurred'
        };
      }
    } catch (e) {
      return {'error': true, 'message': 'Failed to send OTP: $e'};
    }
  }

  Future<Map<String, dynamic>> verifyOtp(int userId, String otp) async {
    try {
      Map<String, dynamic> response = await _apiClient.verifyOtp(userId, otp);

      if (response.containsKey('error') && !response['error']) {
        return {'error': false, 'message': 'OTP verified successfully'};
      } else {
        return {
          'error': true,
          'message': response['message'] ?? 'An error occurred'
        };
      }
    } catch (e) {
      return {'error': true, 'message': 'Failed to verify OTP: $e'};
    }
  }
}
