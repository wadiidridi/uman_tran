
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:um_trans/screens/signin.dart';
import 'package:um_trans/screens/signup.dart';

import '../widgets/custom_button.dart';



class WelcomeScreen extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 80.0), // Décalage du texte vers le bas
          child: Center(
            child: Text(
              'Welcome to You',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 62),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: SvgPicture.asset(
                "assets/icons/chat.svg",
              ),
            ),
            const Spacer(),
          ],
        ),
        Spacer(), // Espace flexible pour centrer les éléments
        const SizedBox(height: 40),
        // Boutons en bas de l'écran
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomButton(
                label: 'Sign In',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                color: Colors.deepPurple, // Couleur personnalisée
                textColor: Colors.white,  // Couleur du texte
              ),
              SizedBox(height: 10), // Espace entre les boutons
              CustomButton(
                label: 'Sign Up',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
                color: Colors.deepPurple.shade200, // Couleur personnalisée
                textColor: Colors.white,  // Couleur du texte
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
