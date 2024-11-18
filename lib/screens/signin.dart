import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:um_trans/screens/signup.dart';
import 'package:um_trans/screens/testing.dart';

import '../widgets/custom_button.dart';
import 'meeting_list.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Titre "Sign In"
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // Image signup.png
            Center(
              child: SvgPicture.asset(
                'assets/icons/login.svg', // Assurez-vous que le chemin de l'image est correct
                height: 250,
              ),
            ),
            const SizedBox(height: 40),

            // Champ pour l'email
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 20),

            // Champ pour le mot de passe
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                labelText: 'Password',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 30),

            // Bouton Sign In
            CustomButton(
              label: 'Sign in',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeetingListScreen()),
                );
              },
              color: Colors.deepPurple, // Couleur personnalisée
              textColor: Colors.white,  // Couleur du texte
            ),

            const SizedBox(height: 20),

            // Texte "Already have an account? Sign Up"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'you dont have an account? ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                    // Action pour le lien "Sign Up"
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
