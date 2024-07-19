import 'package:mate_round/api/api_client.dart';

class LikeUserService {
  final ApiClient _apiClient = ApiClient();

  Future<String> likeUser(int userID, int likeUserID, bool like) async {
    try {
      final response = await _apiClient.likeUser(userID, likeUserID, like);

      if (response.containsKey('status') && response['status'] == 'success') {
        return response['message'] as String;
      } else {
        throw Exception(response['message'] ?? 'An error occurred');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to like/dislike user: $e');
    }
  }
}
