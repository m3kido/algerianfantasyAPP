import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String leaderboardDocId = "W5y6yNzXoNMoo3ZDAyG9"; // ID du document dans Firestore

  Future<void> updateLeaderboard(String username, int newScore) async {
    try {
      DocumentReference leaderboardRef = _firestore.collection('leaderboard').doc(leaderboardDocId);

      // Récupérer le leaderboard actuel
      DocumentSnapshot snapshot = await leaderboardRef.get();
      List<dynamic> leaderboard = [];

      if (snapshot.exists) {
        leaderboard = (snapshot.data() as Map<String, dynamic>)['leader'] ?? [];
      }

      // Convertir en liste de Map
      List<Map<String, dynamic>> sortedLeaderboard = leaderboard.cast<Map<String, dynamic>>();

      // Ajouter le nouveau score
      sortedLeaderboard.add({"name": username, "score": newScore});

      // Trier par score décroissant
      sortedLeaderboard.sort((a, b) => b["score"].compareTo(a["score"]));

      // Garder uniquement les 5 meilleurs scores
      sortedLeaderboard = sortedLeaderboard.sublist(0, 5);

      // Mettre à jour Firestore avec le nouveau leaderboard
      await leaderboardRef.set({"leader": sortedLeaderboard});

      print("Leaderboard mis à jour !");
    } catch (e) {
      print("Erreur lors de la mise à jour du leaderboard : $e");
    }
  }
}
