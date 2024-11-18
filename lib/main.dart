
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:um_trans/screens/welcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: WelcomeScreen(),
    );
  }
}

