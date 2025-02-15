
import 'package:algerianfantasy/models/player_model.dart';
import 'package:flutter/material.dart';

import '../services/players_service.dart';

class PlayerSelectionWidget extends StatefulWidget {
  final String clubname;
  final String position;
  final Function(PlayerModel) onPlayerSelected;

  const PlayerSelectionWidget(
      {super.key, required this.clubname, required this.position,required this.onPlayerSelected});

  @override
  PlayerSelectionWidgetState createState() => PlayerSelectionWidgetState();

}
class PlayerSelectionWidgetState extends State<PlayerSelectionWidget> {
  List<PlayerModel> players =  [];
  bool isLoading=true;
  late PlayerService playerService;

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



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playerService = PlayerService();
    _fetchPlayers();
  }
  Future<void> _fetchPlayers() async {
    try {
      print(players.length);
      List<PlayerModel> fetchedPlayers = await playerService.getPlayersByClubAndPosition(clubName: widget.clubname,position: widget.position);
      print(players.length);
      setState(() {
        players = fetchedPlayers;
        isLoading = false;

      });
    } catch (error) {
      setState(() {
      
        isLoading = false;
      });
      print("daaaaaamns");
    }
  }
  @override
  Widget build(BuildContext context) {





    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.blue.shade900, // 🔹 Semi-transparent dark bg
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "PICK A PLAYER",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,),

                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context), // Close widget
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 jerseys per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8, // Adjusts card proportions
              ),
              itemCount: players.length,
              itemBuilder: (context, index) {
                String playername = players[index].name;
                String playerposition = players[index].position;
                double playerprice = players[index].price;
                String jerseyImage = teamsImages[players[index].club]!;

                return GestureDetector(
                  onTap: () {
                    widget.onPlayerSelected(players[index]);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(jerseyImage, width: 80, fit: BoxFit.contain),
                        const SizedBox(height: 5),
                        Center(
                          child: Text(
                            playername,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        Text(
                          playerposition,
                          style: const TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                        Text(
                          playerprice.toString(),
                          style: const TextStyle(color: Colors.yellow, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

}
}