class User {
  final String email;
  final String password;
  final String? userId; // Champ facultatif

  User({required this.email, required this.password, this.userId});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: '', // Le mot de passe ne devrait pas être exposé
      userId: json['userId'],
    );
  }
}
