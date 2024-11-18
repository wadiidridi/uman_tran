class ApiEndpoints {
  static const String baseUrl = "http://192.168.194.245:5222/api";

  // Auth endpoints
  static const String signUp = "$baseUrl/auth/register/client";
  static const String signIn = "$baseUrl/signin";

  // Meeting-related endpoints
  static const String getMeetings = "$baseUrl/meetings";
  static const String createMeeting = "$baseUrl/meetings/create";

  // Autres endpoints
  static const String userProfile = "$baseUrl/user/profile";
}

