import 'package:flutter/material.dart';

import 'new_meeting.dart';

class MeetingListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meeting List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline), // Icône pour ajouter une nouvelle réunion
            onPressed: () {
              // Naviguer vers la page de création de réunion
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateMeetingScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10, // Nombre d'éléments dans la liste, à ajuster dynamiquement
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.deepPurple),
            title: Text('Meeting ${index + 1}'),
            subtitle: Text('Date: ${DateTime.now().toString()}'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // Action lorsque l'utilisateur tape sur une réunion (peut être une autre page de détails)
            },
          );
        },
      ),
    );
  }
}
