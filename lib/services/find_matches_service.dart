import 'package:mate_round/api/api_client.dart';

class FindMatchesService {
  final ApiClient _apiClient = ApiClient();

  Future<List<dynamic>> findMatches(int userId) async {
    try {
      Map<String, dynamic> response = await _apiClient.getMatches(userId);

      if (response.containsKey('status') && response['status'] == 'success') {
        return response['data'] as List<dynamic>;
      } else {
        throw Exception(response['message'] ?? 'An error occurred');
      }
    } catch (e) {
      throw Exception('Failed to find matches: $e');
    }
  }
}
