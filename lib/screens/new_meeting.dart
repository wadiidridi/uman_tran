import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'audio_upload.dart';

class CreateMeetingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a New Meeting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre pour la création de réunion
            Text(
              'Create a New Meeting',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Champ pour entrer le titre de la réunion
            TextField(
              decoration: InputDecoration(
                labelText: 'Meeting Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Champ pour entrer la date de la réunion
            TextField(
              decoration: InputDecoration(
                labelText: 'Date and Time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Champ pour entrer les participants
            TextField(
              decoration: InputDecoration(
                labelText: 'Participants',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Graphique (chart) fictif, vous pouvez l'adapter à vos besoins
            Container(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 1),
                        FlSpot(1, 3),
                        FlSpot(2, 2),
                        FlSpot(3, 4),
                      ],
                      isCurved: true,
                      colors: [Colors.deepPurple],
                      barWidth: 3,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bouton pour créer la réunion
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AudioRecorderScreen()),
                );
                // Action pour créer la réunion
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Create Meeting',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
