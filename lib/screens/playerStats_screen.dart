import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:algerianfantasy/models/player_model.dart';
import '../services/leaderboard_service.dart';

class PlayerStatsScreen extends StatefulWidget {
  final List<PlayerModel> userPlayers;

  const PlayerStatsScreen({super.key, required this.userPlayers});

  @override
  _PlayerStatsScreenState createState() => _PlayerStatsScreenState();
}

class _PlayerStatsScreenState extends State<PlayerStatsScreen> {
  List<Map<String, dynamic>> playerStats = [];
  int totalScore = 0; // Track total score
  final FirebaseAuth _auth = FirebaseAuth.instance;
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
    super.initState();
    generateRandomStats();
  }

  void generateRandomStats() {
    int newTotalScore = 0; // Reset total score

    setState(() {
      playerStats = widget.userPlayers.map((player) {
        int goals = Random().nextInt(3); // Random 0 to 2 goals
        int assists = Random().nextInt(3); // Random 0 to 2 assists
        int yellowCards = Random().nextInt(2); // 0 or 1 yellow card
        int redCards = (yellowCards == 1) ? Random().nextInt(2) : 0; // Red card if yellow exists
        bool cleanSheet = Random().nextBool(); // 50% chance of clean sheet

        // Calculate points
        int points = (goals * 5) + (assists * 3) + (yellowCards * -2) + (redCards * -5);
        if ((player.position == "GK" || player.position == "DF") && cleanSheet) {
          points += 4;
        }

        newTotalScore += points; // Add player points to total
        totalScore = newTotalScore;
        updatescore();
        return {
          "player": player,
          "goals": goals,
          "assists": assists,
          "yellowCards": yellowCards,
          "redCards": redCards,
          "cleanSheet": cleanSheet,
          "points": points,
        };
      }).toList();

       });
  }
  void updatescore()async{

    LeaderboardService leaderboardService = LeaderboardService();
    User? user =_auth.currentUser;
    await leaderboardService.updateLeaderboard(user?.email,totalScore);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset("assets/background_overlay.png", fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 50),
              Image.asset("assets/logo.png", height: 80),
              const Text(
                "Results have been set !",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Display Total Score
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Total Score: $totalScore pts",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView(
                  children: [
                    buildCategory("GK"),
                    buildCategory("DF"),
                    buildCategory("MF"),
                    buildCategory("FW"),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: (){Navigator.pop(context);},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child:  Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text("CLOSE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCategory(String position) {
    List<Map<String, dynamic>> filteredPlayers = playerStats
        .where((p) => p["player"].position == position)
        .toList();

    if (filteredPlayers.isEmpty) return Container();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            position.toUpperCase(),
            style: const TextStyle(color: Colors.yellow, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...filteredPlayers.map((p) => buildPlayerCard(p)).toList(),
      ],
    );
  }

  Widget buildPlayerCard(Map<String, dynamic> data) {
    PlayerModel player = data["player"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Player Image & Name
                  Row(
                    children: [
                      Image.asset(teamsImages[player.club]!, height: 50),
                      const SizedBox(width: 10),
                      Text(player.name, style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  Text("+${data["points"]} pts", style: const TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${data["goals"]} goals", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  Text("${data["assists"]} assists", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  Text("${data["yellowCards"]} yellow", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  Text("${data["redCards"]} red", style: const TextStyle(color: Colors.white70, fontSize: 14)),
                  if (data["cleanSheet"]) Text("Clean Sheet", style: const TextStyle(color: Colors.greenAccent, fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
