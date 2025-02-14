import 'package:flutter/material.dart';
import 'spot_widget.dart';

class FootballFieldWidget2 extends StatelessWidget {
  const FootballFieldWidget2({super.key});

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
            const SpotWidget(position: "DF", left: 25, top: 370),
            const SpotWidget(position: "DF", left: 125, top: 370),
            const SpotWidget(position: "DF", left: 225, top: 370),
            const SpotWidget(position: "MF", left: 45, top: 220),
            const SpotWidget(position: "MF", left: 90, top: 290),
            const SpotWidget(position: "MF", left: 155, top: 290),
            const SpotWidget(position: "MF", left: 205, top: 220),
            const SpotWidget(position: "MF", left: 125, top: 170),
            const SpotWidget(position: "FW", left: 60, top: 70),
            const SpotWidget(position: "FW", left: 190, top: 70),

          ],
        ));
  }
}
