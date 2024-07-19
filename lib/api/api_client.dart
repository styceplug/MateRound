import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  Future<Map<String, dynamic>> sendRequest(
      String url, Map<String, String> body) async {
    var response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the server');
    }
  }

  Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<Map<String, dynamic>> sendImageRequest(
      String url, File image, int userId) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['user_id'] = userId.toString();

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        image.path,
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to upload image.');
      }
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<Map<String, dynamic>> submitUserInfo(
      Map<String, String> userInfo) async {
    var response = await http.post(
      Uri.parse("https://materound.com/app/api/v1/profile/submit_info.php"),
      body: userInfo,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit user info');
    }
  }

  Future<Map<String, dynamic>> sendOtpRequest(int userId) async {
    var response = await http.post(
      Uri.parse("https://materound.com/app/api/v1/otp/send_otp.php"),
      body: {'user_id': userId.toString()},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(int userId, String otp) async {
    var response = await http.post(
      Uri.parse("https://materound.com/app/api/v1/otp/verify_otp.php"),
      body: {'user_id': userId.toString(), 'otp': otp},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  Future<Map<String, dynamic>> submitExpectations(
      int userId, List<String> expectations) async {
    var response = await http.post(
      Uri.parse("https://materound.com/app/api/v1/expectations/submit.php"),
      body: {
        'user_id': userId.toString(),
        'expectations': jsonEncode(expectations),
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to submit expectations');
    }
  }

  Future<Map<String, dynamic>> getMatches(int userId) async {
    final url =
        "https://materound.com/app/api/v1/home/get_matches.php?userID=$userId";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get matches');
      }
    } catch (e) {
      throw Exception('Failed to get matches: $e');
    }
  }

  Future<Map<String, dynamic>> getUser(int userId) async {
    final url =
        "https://materound.com/app/api/v1/home/get_user.php?userID=$userId";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get user');
      }
    } catch (e) {
      throw Exception('Failed to get user $e');
    }
  }

  Future<Map<String, dynamic>> likeUser(
      int userID, int likeUserID, bool like) async {
    const url = "https://materound.com/app/api/v1/home/like_user.php";
    final body = {
      'userID': userID.toString(),
      'likeUserID': likeUserID.toString(),
      'like': like ? '1' : '0',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to like/dislike user');
      }
    } catch (e) {
      throw Exception('Failed to like/dislike user: $e');
    }
  }

  Future<Map<String, dynamic>> getConversations(int userId) async {
    final url =
        'https://materound.com/app/api/v1/messages/get_conversations.php?userID=$userId';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get conversations');
      }
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }

  Future<Map<String, dynamic>> getConversation(
      int userId, int partnerUserID) async {
    final url =
        'https://materound.com/app/api/v1/messages/get_conversation.php?userID=$userId&partnerUserID=$partnerUserID';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get conversation');
      }
    } catch (e) {
      throw Exception('Failed to get conversation: $e');
    }
  }

  Future<Map<String, dynamic>> sendMessage(
      int userId, int partnerUserID, String text) async {
    const url = 'https://materound.com/app/api/v1/messages/send_message.php';

    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final body = {
      'userID': userId.toString(),
      'partnerUserID': partnerUserID.toString(),
      'text': text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to send message');
      }
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }
}
