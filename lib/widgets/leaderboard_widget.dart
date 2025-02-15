import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LeaderboardWidget extends StatefulWidget {
  const LeaderboardWidget({super.key});

  @override
  State<LeaderboardWidget> createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends State<LeaderboardWidget> {
  List<Map<String, dynamic>> leaderBoard = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String leaderboardDocId = "W5y6yNzXoNMoo3ZDAyG9"; // Firestore document ID

  @override
  void initState() {
    super.initState();
    getLeaderBoard();
  }

  void getLeaderBoard() async {
    DocumentReference leaderboardRef = _firestore.collection('leaderBoard').doc(leaderboardDocId);
    print("g");
    DocumentSnapshot snapshot = await leaderboardRef.get();
    if (snapshot.exists) {
      List<dynamic> leaderboardData = (snapshot.data() as Map<String, dynamic>)['leader'] ?? [];

      List<Map<String, dynamic>> sortedLeaderboard = leaderboardData
          .map((e) => {"name": e["name"], "score": e["score"]}) // Convert explicitly
          .toList();
    print("rop");
      setState(() {
        leaderBoard = sortedLeaderboard;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const Text(
          "Leaderboard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // 🔹 Top 3 Players
        if (leaderBoard.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leaderBoard.length > 1) _buildTopPlayer(leaderBoard[1], 2),
              _buildTopPlayer(leaderBoard[0], 1, isFirst: true),
              if (leaderBoard.length > 2) _buildTopPlayer(leaderBoard[2], 3),
            ],
          ),
          const SizedBox(height: 20),
        ],

        // 🔹 Remaining Players List
        if (leaderBoard.isNotEmpty)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: List.generate(leaderBoard.length, (index) {
                final player = leaderBoard[index];
                return _buildRankedPlayer(player, index + 1);
              }),
            ),
          ),
        if (leaderBoard.isEmpty)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  // 🔹 Top 3 Player Widget
  Widget _buildTopPlayer(Map<String, dynamic> player, int rank, {bool isFirst = false}) {
    return Column(
      children: [
        Container(
          width: isFirst ? 80 : 70,
          height: isFirst ? 80 : 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple.shade300,
            border: Border.all(color: Colors.white, width: isFirst ? 3 : 2),
          ),
          child: Center(
            child: Text(
              player['name'][0], // First letter of name
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          player['name'],
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        Text(
          "${player['score']} pts", // 🔹 FIXED: Changed 'points' to 'score'
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  // 🔹 Ranked Player Widget
  Widget _buildRankedPlayer(Map<String, dynamic> player, int rank) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade700,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$rank  ${player['name']}",
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            "${player['score']} pts", // 🔹 FIXED: Changed 'points' to 'score'
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
