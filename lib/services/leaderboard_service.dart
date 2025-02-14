import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String leaderboardDocId = "W5y6yNzXoNMoo3ZDAyG9"; // ID du document dans Firestore

  Future<void> updateLeaderboard(String username, int newScore) async {
    try {
      DocumentReference leaderboardRef = _firestore.collection('leaderboard').doc(leaderboardDocId);

      DocumentSnapshot snapshot = await leaderboardRef.get();
      List<dynamic> leaderboard = [];

      if (snapshot.exists) {
        leaderboard = (snapshot.data() as Map<String, dynamic>)['leader'] ?? [];
      }

      List<Map<String, dynamic>> sortedLeaderboard = leaderboard.cast<Map<String, dynamic>>();

      sortedLeaderboard.add({"name": username, "score": newScore});

      sortedLeaderboard.sort((a, b) => b["score"].compareTo(a["score"]));

      sortedLeaderboard = sortedLeaderboard.sublist(0, 5);

      await leaderboardRef.set({"leader": sortedLeaderboard});

      print("Leaderboard mis à jour !");
    } catch (e) {
      print("Erreur lors de la mise à jour du leaderboard : $e");
    }
  }
}
