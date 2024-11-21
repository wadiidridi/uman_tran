import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/config.dart';
import '../models/AudioFile.dart';
import 'dart:convert'; // Pour décoder les réponses JSON

class AudioService {
  Future<String> uploadAudio(AudioFile audioFile) async {
    final Uri url = Uri.parse(ApiEndpoints.transcription);

    try {
      var request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath(
        'audio', // Nom du champ attendu par l'API
        audioFile.filePath,
      ));

      var response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("Audio uploaded successfully!");
        // Décodage du JSON pour extraire la transcription
        final responseData = jsonDecode(responseBody);
        return responseData['transcription'] ?? "Aucune transcription disponible.";
      } else {
        throw Exception("Échec de l'upload : ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("Erreur lors de l'upload de l'audio : $e");
    }
  }
}