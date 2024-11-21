import 'package:flutter/material.dart';

class TranscriptionScreen extends StatefulWidget {
  final String transcription;

  const TranscriptionScreen({required this.transcription, Key? key}) : super(key: key);

  @override
  _TranscriptionScreenState createState() => _TranscriptionScreenState();
}

class _TranscriptionScreenState extends State<TranscriptionScreen> {
  late TextEditingController _transcriptionController;

  @override
  void initState() {
    super.initState();
    // Initialisation du contrôleur avec la transcription existante
    _transcriptionController = TextEditingController(text: widget.transcription);
  }

  @override
  void dispose() {
    _transcriptionController.dispose(); // Libération du contrôleur
    super.dispose();
  }

  void _saveTranscription() {
    // Sauvegarde de la transcription modifiée
    String modifiedTranscription = _transcriptionController.text;
    // Vous pouvez ici envoyer la transcription modifiée à un backend ou autre service
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Transcription modifiée : $modifiedTranscription")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transcription"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Transcription :",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16.0),
            // Zone de texte pour modifier la transcription
            TextField(
              controller: _transcriptionController,
              maxLines: 10,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Modifier la transcription",
              ),
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _saveTranscription,
              child: const Text("Sauvegarder"),
            ),
          ],
        ),
      ),
    );
  }
}
