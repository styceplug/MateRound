import 'package:mate_round/api/api_client.dart';

class GetUserService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> getUser(int userId) async {
    try {
      Map<String, dynamic> response = await _apiClient.getUser(userId);

      if (response.containsKey('status') && response['status'] == 'success') {
        return response['data'] as Map<String, dynamic>;
      } else {
        throw Exception(response['message'] ?? 'An error occurred');
      }
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }
}
