class Meeting {
  final String sujetReunion;
  final String heure;
  final String nombreParticipants;
  final String date;

  Meeting({
    required this.sujetReunion,
    required this.heure,
    required this.nombreParticipants,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "sujetReunion": sujetReunion,
      "heure": heure,
      "nombreParticipants": nombreParticipants,
      "date": date,
    };
  }
}
