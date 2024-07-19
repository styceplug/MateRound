import 'package:shared_preferences/shared_preferences.dart';
import 'package:mate_round/api/api_client.dart';

class LoginService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> login(
      String email, String password, bool remember) async {
    var data = await _apiClient.sendRequest(
      "https://materound.com/app/api/v1/auth/login.php",
      {
        'email': email,
        'password': password,
        'remember': remember.toString(),
      },
    );

    if (!data['error']) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setInt('userId', int.parse(data['userId'].toString()));
      await prefs.setString('firstName', data['firstName']);
      await prefs.setString('lastName', data['lastName']);
      await prefs.setInt('isPro', int.parse(data['isPro'].toString()));
      await prefs.setInt('proType', int.parse(data['proType'].toString()));
    }

    return data;
  }

  Future<Map<String, dynamic>> deactivateAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 0;

    if (userId == 0) {
      return {
        'error': true,
        'message': 'User ID not found'
      };
    }

    var data = await _apiClient.sendRequest(
      "https://materound.com/app/api/v1/auth/deactivate.php",
      {
        'account_id': userId.toString(),
      },
    );

    return data;
  }
}
