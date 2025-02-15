import 'package:algerianfantasy/models/player_model.dart';
import 'package:flutter/material.dart';

import 'PlayerSelectionWidget.dart';

class TeamSelectionWidget extends StatefulWidget {
  final Function(PlayerModel) onPlayerSelected;
  String position;
  TeamSelectionWidget({super.key,required this.position ,required this.onPlayerSelected});

  @override
  TeamSelectionWidgetState createState() => TeamSelectionWidgetState();
}

class TeamSelectionWidgetState extends State<TeamSelectionWidget> {
  String? selectedTeam;


  List<Map<String, String>> teams = [
    {"name": "Espérance sportive de Mostaganem - ESM", "abv": "ESM", "image": "assets/jerseys/esm_kit.png"},
    {"name": "Club sportif constantinois - CSC", "abv": "CSC", "image": "assets/jerseys/csc_kit.png"},
    {"name": "Chabab Riadhi Belouizdad - CRB", "abv": "CRB", "image": "assets/jerseys/crb_kit.png"},
    {"name": "Association sportive olympique de Chlef - ASOC", "abv": "ASOC", "image": "assets/jerseys/asoc_kit.png"},
    {"name": "Entente sportive sétifienne - ESS", "abv": "ESS", "image": "assets/jerseys/ess_kit.png"},
    {"name": "Jeunesse sportive de Kabylie - JSK", "abv": "JSK", "image": "assets/jerseys/jsk_kit.png"},
    {"name": "Jeunesse sportive de Saoura - JSS", "abv": "JSS", "image": "assets/jerseys/saoura_kit.png"},
    {"name": "Mouloudia Club El Bayadh - MCB", "abv": "MCB", "image": "assets/jerseys/bayadh_kit.png"},
    {"name": "Mouloudia Club d'Alger - MCA", "abv": "MCA", "image": "assets/jerseys/mca_kit.png"},
    {"name": "Mouloudia Club d'Oran - MCO", "abv": "MCO", "image": "assets/jerseys/mco_kit.png"},
  ];




  List<PlayerModel>? teamPlayers ;

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
                  "PICK A TEAM",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () => Navigator.pop(context), // Close widget
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 GridView for teams
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 jerseys per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8, // Adjusts card proportions
              ),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                String teamName = teams[index]["abv"]!;
                String jerseyImage = teams[index]["image"]!;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTeam = teamName;
                    });
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerSelectionWidget(clubname: teams[index]["name"]!,position: widget.position,onPlayerSelected:  widget.onPlayerSelected),
                      ),
                    );

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: selectedTeam == teamName ? Colors.red : Colors.white, // 🔹 Red border if selected
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(jerseyImage, fit: BoxFit.contain),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            teamName,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
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
