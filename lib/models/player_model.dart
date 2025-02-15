class PlayerModel {
  final String id;
  final String name;
  final String position;
  final String club;
  final double price;

  PlayerModel({
    required this.id,
    required this.name,
    required this.position,
    required this.club,
    required this.price,
  });

  // Convertir JSON → Objet

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'] ?? "unknown_id",
      // Default value if missing
      name: json['name'] ?? "Unknown Player",
      position: json['position'] ?? "Unknown Position",
      club: json['club'] ?? "Unknown Club",
      price: (json['price'] ?? 0.0).toDouble(), // Ensures it's a double
    );
  }
}