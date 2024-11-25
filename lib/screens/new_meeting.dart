import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/meeting_model.dart';
import '../services/meeting_service.dart';
import 'audio_upload.dart';

class CreateMeetingScreen extends StatefulWidget {
  const CreateMeetingScreen({Key? key}) : super(key: key);

  @override
  _CreateMeetingScreenState createState() => _CreateMeetingScreenState();
}

class _CreateMeetingScreenState extends State<CreateMeetingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _sujetController = TextEditingController();
  final _heureController = TextEditingController();
  final _participantsController = TextEditingController();
  final _dateController = TextEditingController();

  final MeetingService _meetingService = MeetingService();

  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString('userId');
    });
  }

  void _createMeeting() async {
    if (_formKey.currentState!.validate()) {
      if (_userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User ID not found. Please log in again.")),
        );
        return;
      }

      final meeting = Meeting(
        sujetReunion: _sujetController.text,
        heure: _heureController.text,
        nombreParticipants: _participantsController.text,
        date: _dateController.text,
      );

      try {
        await _meetingService.createMeeting(meeting);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Meeting created successfully!")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioRecorderScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create meeting: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a New Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _sujetController,
                decoration: const InputDecoration(
                  labelText: 'Meeting Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _heureController,
                decoration: const InputDecoration(
                  labelText: 'Time (e.g., 14:00)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _participantsController,
                decoration: const InputDecoration(
                  labelText: 'Number of Participants',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of participants';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date (e.g., 2024-11-20)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createMeeting,
                child: const Text('Create Meeting'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
