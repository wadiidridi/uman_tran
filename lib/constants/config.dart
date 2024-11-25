class ApiEndpoints {
  static const String baseUrl = "http://192.168.1.16:5222/api";

  // Auth endpoints
  static const String signUp = "$baseUrl/auth/register/client";
  static const String signIn = "$baseUrl/auth/login";

  // Meeting-related endpoints
  static const String getMeetings = "$baseUrl/meeting'";
  static const String createMeeting = "$baseUrl/auth/meeting";

  // Autres endpoints
  static const String transcription = "$baseUrl/auth/transcribe";
}

