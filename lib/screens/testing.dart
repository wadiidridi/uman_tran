// import 'package:flutter/material.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class RecordScreen extends StatefulWidget {
//   @override
//   _RecordScreenState createState() => _RecordScreenState();
// }
//
// class _RecordScreenState extends State<RecordScreen> {
//   final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   final FlutterSoundPlayer _player = FlutterSoundPlayer();
//   bool _isRecording = false;
//   String? _audioPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeRecorder();
//   }
//
//   // Initialiser l'enregistreur et demander les permissions
//   Future<void> _initializeRecorder() async {
//     var status = await Permission.microphone.request();
//     if (status.isGranted) {
//       await _recorder.openRecorder();
//       await _player.openPlayer();
//     } else {
//       print("Permission microphone refusée");
//     }
//   }
//
//   // Démarrer l'enregistrement
//   Future<void> _startRecording() async {
//     try {
//       String filePath = '/storage/emulated/0/Download/audio_record.aac'; // Définir un chemin pour l'audio
//       await _recorder.startRecorder(toFile: filePath);
//       setState(() {
//         _isRecording = true;
//         _audioPath = filePath;
//       });
//     } catch (e) {
//       print("Erreur lors de l'enregistrement: $e");
//     }
//   }
//
//   // Arrêter l'enregistrement
//   Future<void> _stopRecording() async {
//     try {
//       String? path = await _recorder.stopRecorder();
//       setState(() {
//         _isRecording = false;
//         _audioPath = path;
//       });
//       if (path != null) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Enregistrement terminé : $path')),
//         );
//       }
//     } catch (e) {
//       print("Erreur lors de l'arrêt de l'enregistrement: $e");
//     }
//   }
//
//   // Lire l'audio enregistré
//   Future<void> _playAudio() async {
//     if (_audioPath != null) {
//       await _player.startPlayer(fromURI: _audioPath!);
//     }
//   }
//
//   @override
//   void dispose() {
//     _recorder.closeRecorder();
//     _player.closePlayer();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enregistrement Audio')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _isRecording ? _stopRecording : _startRecording,
//               child: Text(_isRecording ? 'Arrêter' : 'Enregistrer'),
//             ),
//             SizedBox(height: 20),
//             if (_audioPath != null)
//               ElevatedButton(
//                 onPressed: _playAudio,
//                 child: Text('Lire l\'audio'),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// //