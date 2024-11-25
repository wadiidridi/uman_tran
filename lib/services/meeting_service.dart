import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constants/config.dart';
import '../models/meeting_model.dart';

class MeetingService {
  Future<void> createMeeting(Meeting meeting) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null) {
      throw Exception("User ID not found. Please log in again.");
    }

    final Uri url = Uri.parse("${ApiEndpoints.createMeeting}/$userId");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(meeting.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Meeting created successfully!");
      } else {
        throw Exception("Failed to create meeting: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Error while creating meeting: $e");
    }
  }
}
