import 'package:mate_round/api/api_client.dart';

class ExpectationsService {
  final ApiClient _apiClient = ApiClient();

  Future<Map<String, dynamic>> submitExpectations(
      int userId, List<String> expectations) async {
    try {
      Map<String, dynamic> response =
          await _apiClient.submitExpectations(userId, expectations);

      if (response.containsKey('error') && !response['error']) {
        return {
          'error': false,
          'message': 'Expectations submitted successfully'
        };
      } else {
        return {
          'error': true,
          'message': response['message'] ?? 'An error occurred'
        };
      }
    } catch (e) {
      return {'error': true, 'message': 'Failed to submit expectations: $e'};
    }
  }
}
