import 'package:mate_round/api/api_client.dart';

class SignUpService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> signUp(String email, String password, String phoneNumber, String country, String mobileDeviceId, String mobileDevice) async {
    var data = await _apiClient.sendRequest(
      "https://materound.com/app/api/v1/auth/signup.php",
      {
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'country': country,
        'mobile_device_id': mobileDeviceId,
        'mobile_device': mobileDevice,
      },
    );

    if (!data['error']) {
      await _apiClient.storeToken(data['token']);
    }

    return data;
  }
}
