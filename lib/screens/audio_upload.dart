import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';

class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  FlutterSoundRecorder? _recorder;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _audioFilePath;

  bool _isRecording = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();

    if (await Permission.microphone.request().isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Microphone permission is required.")),
      );
    }
  }

  Future<void> _startRecording() async {
    final tempDir = await getTemporaryDirectory();
    _audioFilePath = '${tempDir.path}/recording.aac';
    await _recorder!.startRecorder(toFile: _audioFilePath);
    setState(() {
      _isRecording = true;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _playAudio() async {
    if (_audioFilePath == null) return;
    await _audioPlayer.play(DeviceFileSource(_audioFilePath!));
    setState(() {
      _isPlaying = true;
    });
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _deleteAudio() async {
    if (_audioFilePath == null) return;
    final file = File(_audioFilePath!);
    if (await file.exists()) {
      await file.delete();
    }
    setState(() {
      _audioFilePath = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Audio file deleted.")),
    );
  }

  Future<void> _uploadAudio() async {
    if (_audioFilePath == null) return;
    const uploadUrl =
        'https://example.com/api/upload'; // Replace with your API URL
    final file = File(_audioFilePath!);

    final formData = FormData.fromMap({
      'file':
      await MultipartFile.fromFile(file.path, filename: 'recording.aac'),
    });

    final dio = Dio();
    try {
      final response = await dio.post(uploadUrl, data: formData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload successful: ${response.statusCode}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Upload failed: $e")),
      );
    }
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Recorder"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isRecording ? _stopRecording : _startRecording,
              child: Text(_isRecording ? "Stop Recording" : "Start Recording"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isPlaying ? _stopAudio : _playAudio,
              child: Text(_isPlaying ? "Stop Playback" : "Play Audio"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _deleteAudio,
              child: const Text("Delete Audio"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadAudio,
              child: const Text("Upload Audio"),
            ),
          ],
        ),
      ),
    );
  }
}
