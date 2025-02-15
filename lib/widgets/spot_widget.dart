import 'package:algerianfantasy/models/player_model.dart';
import 'package:flutter/material.dart';

import 'TeamSelctionWidget.dart';

class SpotWidget extends StatefulWidget {
  final String position;
  final double left;
  final double top;
  final Function() getBalance;
  final Function(double) subtractBalance;
  final Function(PlayerModel) addplayer;
  final Function(PlayerModel) removeplayer;

  const SpotWidget({
    super.key,
    required this.position,
    required this.left,
    required this.top, required this.getBalance, required this.subtractBalance, required this.addplayer, required this.removeplayer,
  });

  @override
  SpotWidgetState createState() => SpotWidgetState();
}

class SpotWidgetState extends State<SpotWidget> {
  bool occupied = false; // 🔹 Définit si l'emplacement est occupé ou non
  PlayerModel? selectedPlayer;
  void onPlayerSelected(PlayerModel player){
    if(widget.subtractBalance(player.price)){
      widget.addplayer(player);
      setState(() {
        occupied = true;
        selectedPlayer=player;
      });
    }

  }
  void showSelectionDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) =>  TeamSelectionWidget(
        position:widget.position,

        onPlayerSelected:onPlayerSelected,
      ),
    );
  }
  void toggleOccupied() {
    if(occupied==false){
      showSelectionDialog();
    }
    else{
      widget.subtractBalance(-1*selectedPlayer!.price);
      widget.removeplayer(selectedPlayer!);
      setState(() {
        occupied=false;
        selectedPlayer=null;
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: GestureDetector(
        onTap: toggleOccupied,
        child: occupied
            ? PlayerWidget(player:selectedPlayer) // 🔹 Affiche un joueur
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
  final PlayerModel? player;

  const PlayerWidget({super.key,required this.player});

  @override
  Widget build(BuildContext context) {
    Map<String, String> teamsImages = {
      "Espérance sportive de Mostaganem - ESM": "assets/jerseys/esm_kit.png",
      "Club sportif constantinois - CSC": "assets/jerseys/csc_kit.png",
      "Chabab Riadhi Belouizdad - CRB": "assets/jerseys/crb_kit.png",
      "Association sportive olympique de Chlef - ASOC": "assets/jerseys/asoc_kit.png",
      "Entente sportive sétifienne - ESS": "assets/jerseys/ess_kit.png",
      "Jeunesse sportive de Kabylie - JSK": "assets/jerseys/jsk_kit.png",
      "Jeunesse sportive de Saoura - JSS": "assets/jerseys/saoura_kit.png",
      "Mouloudia Club El Bayadh - MCB": "assets/jerseys/bayadh_kit.png",
      "Mouloudia Club d'Alger - MCA": "assets/jerseys/mca_kit.png",
      "Mouloudia Club d'Oran - MCO": "assets/jerseys/mco_kit.png",
    };
    return Column(
      children: [
        Container(
          width: 50,
          child: Image.asset(teamsImages[player?.club]!),

        ),
        const SizedBox(height: 5),
        SizedBox(
          width: 50,
          child: Text(
            player!.name,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}

