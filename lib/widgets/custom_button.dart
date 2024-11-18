import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label; // Texte du bouton
  final VoidCallback onPressed; // Action au clic
  final Color color; // Couleur de fond
  final Color textColor; // Couleur du texte

  const CustomButton({
    required this.label,
    required this.onPressed,
    this.color = Colors.deepPurple, // Couleur par défaut
    this.textColor = Colors.white,  // Couleur par défaut du texte
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}
