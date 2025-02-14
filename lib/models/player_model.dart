class PlayerModel {
  final String id;
  final String name;
  final String position;
  final int price;

  PlayerModel({
    required this.id,
    required this.name,
    required this.position,
    required this.price,
  });

  // Convertir JSON → Objet
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      price: json['price'],
    );
  }

  // Convertir Objet → JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'price': price,
    };
  }
}
