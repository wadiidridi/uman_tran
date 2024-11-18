import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:um_trans/services/auth_service.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import 'signin.dart';

class SignUpScreen extends StatelessWidget {
  // Ajout des contrôleurs
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService(); // Instance de AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Titre "Sign Up"
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Text(
                'Sign Up',
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
                'assets/icons/signup.svg',
                height: 250,
              ),
            ),
            const SizedBox(height: 40),

            // Champ pour l'email
            TextField(
              controller: emailController, // Liaison au contrôleur
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
              controller: passwordController, // Liaison au contrôleur
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

            // Bouton Sign Up
            CustomButton(
              label: 'Sign Up',
              onPressed: () async {
                print("pressed");
                String email = emailController.text.trim();
                String password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill in all fields.')),
                  );
                  return;
                }

                try {
                  User user = User(email: email, password: password);
                  await _authService.signUp(user);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign Up Successful!')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Sign Up Failed: $e')),
                  );
                }
              },
              color: Colors.deepPurple,
              textColor: Colors.white,
            ),

            const SizedBox(height: 20),

            // Texte "Already have an account? Sign In"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Text(
                    'Sign In',
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
