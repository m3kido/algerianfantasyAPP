import 'package:flutter/material.dart';
import 'spot_widget.dart';

class FootballFieldWidget1 extends StatelessWidget {
  const FootballFieldWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300, // 🔹 Largeur fixée à 330px
        height: 550, // 🔹 Hauteur fixée à 630px
        child: Stack(
        children: [
        // 🔹 Image de fond du terrain
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // 🟢 Ajout du border radius
              child: Opacity(
                opacity: 1.0, // 🔵 Opacité à 100% (pas de transparence)
                child: Image.asset(
                  'assets/Lineups.png', // Change selon ton image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        // 🏃‍♂️ Positions des joueurs
        const SpotWidget(position: "GK", left: 125, top: 460),
        const SpotWidget(position: "DF", left: 25, top: 320),
        const SpotWidget(position: "DF", left: 90, top: 360),
        const SpotWidget(position: "DF", left: 160, top: 360),
        const SpotWidget(position: "DF", left: 225, top: 320),
        const SpotWidget(position: "MF", left: 45, top: 220),
        const SpotWidget(position: "MF", left: 205, top: 220),
        const SpotWidget(position: "MF", left: 125, top: 160),
        const SpotWidget(position: "FW", left: 25, top: 70),
        const SpotWidget(position: "FW", left: 225, top: 70),
        const SpotWidget(position: "FW", left: 125, top: 30),
      ],
    ));
  }
}
