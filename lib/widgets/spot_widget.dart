import 'package:flutter/material.dart';

class SpotWidget extends StatefulWidget {
  final String position;
  final double left;
  final double top;

  const SpotWidget({
    super.key,
    required this.position,
    required this.left,
    required this.top,
  });

  @override
  SpotWidgetState createState() => SpotWidgetState();
}

class SpotWidgetState extends State<SpotWidget> {
  bool occupied = false; // 🔹 Définit si l'emplacement est occupé ou non

  void toggleOccupied() {
    setState(() {
      occupied = !occupied;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: toggleOccupied,
        child: occupied
            ? PlayerWidget(position: widget.position) // 🔹 Affiche un joueur
            : EmptySpotWidget(position: widget.position), // 🔹 Affiche le bouton d'ajout
      ),
    );
  }
}

// 🔹 Widget affiché quand le spot est vide
class EmptySpotWidget extends StatelessWidget {
  final String position;

  // 🔹 Détermine la couleur en fonction de la position
  Color getPositionColor() {
    if (position.contains("GK")) return Colors.yellow;
    if (position.contains("DF")) return Colors.blue;
    if (position.contains("MF")) return Colors.purple;
    if (position.contains("FW")) return Colors.red;
    return Colors.grey; // 🔹 Couleur par défaut si rien ne correspond
  }

  const EmptySpotWidget({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: getPositionColor(),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Center(
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          position,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}

// 🔹 Widget affiché quand un joueur est placé (remplace-le plus tard)
class PlayerWidget extends StatelessWidget {
  final String position;

  const PlayerWidget({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: const Center(
            child: Icon(Icons.person, color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          position,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
