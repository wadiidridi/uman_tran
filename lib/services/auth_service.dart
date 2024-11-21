import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../constants/config.dart';
class AuthService {
  Future<void> signUp(User user) async {
    final url = Uri.parse(ApiEndpoints.signUp);

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );

      // Affiche la réponse pour le débogage
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 201) {
        print("Sign up successful!");
      } else {
        // Si le statut n'est pas 201, cela échoue, affiche une erreur avec le corps de la réponse
        print("Sign up failed with status: ${response.statusCode}");
        throw Exception("Failed to sign up: ${response.body}");
      }
    } catch (e) {
      // Gérer les erreurs de réseau ou autres exceptions
      print("Error: $e");
      throw Exception("Network error or other issue: $e");
    }
  }


  Future<bool> signIn(User user) async {
    final Uri url = Uri.parse(ApiEndpoints.signIn);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()), // Utilisation du modèle User
    );

    if (response.statusCode == 200) {
      // Connexion réussie
      return true;
    } else {
      // Échec de la connexion
      return false;
    }
  }
}
