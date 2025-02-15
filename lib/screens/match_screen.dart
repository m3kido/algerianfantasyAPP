import 'package:algerianfantasy/models/player_model.dart';
import 'package:algerianfantasy/screens/playerStats_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MatchSimulationScreen extends StatefulWidget {
  final List<PlayerModel> userPlayers;
  MatchSimulationScreen({super.key, required this.userPlayers});
  @override
  _MatchSimulationScreenState createState() => _MatchSimulationScreenState();
}

class _MatchSimulationScreenState extends State<MatchSimulationScreen> {
  List<Map<String, dynamic>> matches = [];
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

  void runSimulation() {
    setState(() {
      // Ensure we have an even number of teams
      List<Map<String, String>> shuffledTeams = List.from(teams)..shuffle();

      if (shuffledTeams.length % 2 != 0) {
        shuffledTeams.removeLast(); // Remove the last team if odd
      }

      // Generate matches dynamically based on available teams
      matches = List.generate(shuffledTeams.length ~/ 2, (index) {
        return {
          "team1": shuffledTeams[index * 2],
          "team2": shuffledTeams[index * 2 + 1],
          "result": "${Random().nextInt(4)} - ${Random().nextInt(4)}",
        };
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runSimulation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset("assets/background_overlay.png", fit: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 50),
              // Logo & Title
              Image.asset("assets/logo.png", height: 80),
              const Text(
                "Results have been set !",
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              // Match List
              Expanded(
                child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (context, index) {
                    var match = matches[index];
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Team 1
                              Column(
                                children: [
                                  Image.asset(match["team1"]["image"], height: 50),
                                  Text(match["team1"]["abv"], style: const TextStyle(color: Colors.white, fontSize: 16)),
                                ],
                              ),
                              // Match Info
                              Column(
                                children: [
                                  const Text("10:30 PM", style: TextStyle(color: Colors.white70, fontSize: 14)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      match["result"],
                                      style: const TextStyle(color: Colors.yellow, fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              // Team 2
                              Column(
                                children: [
                                  Image.asset(match["team2"]["image"], height: 50),
                                  Text(match["team2"]["abv"], style: const TextStyle(color: Colors.white, fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Bottom Section
              const Text("Your Points →", style: TextStyle(color: Colors.white70, fontSize: 18)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PlayerStatsScreen(userPlayers:widget.userPlayers,)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text("NEXT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }
}
