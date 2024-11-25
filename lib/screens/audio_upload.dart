import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:um_trans/screens/playback.dart';

class AudioRecorderScreen extends StatefulWidget {
  const AudioRecorderScreen({super.key});

  @override
  _AudioRecorderScreenState createState() => _AudioRecorderScreenState();
}

class _AudioRecorderScreenState extends State<AudioRecorderScreen> {
  FlutterSoundRecorder? _recorder;
  String? _audioFilePath;

  bool _isRecording = false;
  bool _isPaused = false;

  double _soundLevel = 0.0;

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

    _recorder!.setSubscriptionDuration(const Duration(milliseconds: 100));
    _recorder!.onProgress!.listen((event) {
      setState(() {
        _soundLevel = event.decibels ?? 0.0; // Get decibels if available
      });
    });
  }

  Future<void> _startRecording() async {
    final tempDir = await getTemporaryDirectory();
    _audioFilePath = '${tempDir.path}/recording.aac';
    await _recorder!.startRecorder(toFile: _audioFilePath);
    setState(() {
      _isRecording = true;
      _isPaused = false;
    });
  }

  Future<void> _pauseRecording() async {
    await _recorder!.pauseRecorder();
    setState(() {
      _isPaused = true;
    });
  }

  Future<void> _resumeRecording() async {
    await _recorder!.resumeRecorder();
    setState(() {
      _isPaused = false;
    });
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });

    // Navigate to playback screen
    if (_audioFilePath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlaybackScreen(audioFilePath: _audioFilePath!),
        ),
      );
    }
  }

  void _showRecordingPopup() {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Recording..."),
              const SizedBox(height: 16),
              _buildWaveform(), // Add waveform widget here
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                    onPressed: _isPaused ? _resumeRecording : _pauseRecording,
                    iconSize: 40,
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      _stopRecording();
                      Navigator.pop(context); // Close the popup
                    },
                    iconSize: 40,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWaveform() {
    final barHeight = max(10, _soundLevel * 2); // Scale decibel values
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        10, // Number of bars
            (index) => Container(
          width: 5,
          height: Random().nextDouble() * barHeight, // Simulated animation
          margin: const EdgeInsets.symmetric(horizontal: 2),
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Recorder"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _startRecording();
            _showRecordingPopup();
          },
          child: const Text("Start Recording"),
        ),
      ),
    );
  }
}
