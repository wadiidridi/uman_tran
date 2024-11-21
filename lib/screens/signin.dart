import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:um_trans/screens/signup.dart';
import 'package:um_trans/screens/testing.dart';
import '../models/user_model.dart';
import '../widgets/custom_button.dart';
import 'meeting_list.dart';
import '../services/auth_service.dart'; // Assurez-vous que le chemin est correct

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog("Please fill in all fields.");
      return;
    }

    setState(() {
      _isLoading = true;
    });

    User user = User(email: email, password: password);
    bool success = await _authService.signIn(user);

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Redirection en cas de succès
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MeetingListScreen()),
      );
    } else {
      // Affiche une alerte en cas d'échec
      _showErrorDialog("Invalid credentials. Please try again.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

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
              controller: _emailController,
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
              controller: _passwordController,
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
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : CustomButton(
              label: 'Sign in',
              onPressed: _signIn,
              color: Colors.deepPurple, // Couleur personnalisée
              textColor: Colors.white, // Couleur du texte
            ),

            const SizedBox(height: 20),

            // Texte "Already have an account? Sign Up"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You don\'t have an account? ',
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
