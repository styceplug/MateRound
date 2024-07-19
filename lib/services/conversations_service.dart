import 'package:mate_round/api/api_client.dart';

class ConversationsService {
  final ApiClient _apiClient = ApiClient();

  Future<List<dynamic>> getConversations(int userId) async {
    try {
      Map<String, dynamic> response = await _apiClient.getConversations(userId);
      if (response.containsKey('status') && response['status'] == 'success') {
        return response['data'] as List<dynamic>;
      } else {
        throw Exception(response['message'] ?? 'An error occurred');
      }
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  Future<List<dynamic>> getConversation(int userId, int partnerUserID) async {
    try {
      Map<String, dynamic> response =
          await _apiClient.getConversation(userId, partnerUserID);

      if (response.containsKey('status') && response['status'] == 'success') {
        return response['data'] as List<dynamic>;
      } else {
        throw Exception(response['message'] ?? 'An error occurred');
      }
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  Future<Map<String, dynamic>> sendMessage(
      int userId, int partnerUserID, String text) async {
    try {
      Map<String, dynamic> response =
          await _apiClient.sendMessage(userId, partnerUserID, text);

      if (response.containsKey('status') && response['status'] == 'success') {
        return response;
      } else {
        throw Exception(response['message'] ?? 'An error occurred');
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
