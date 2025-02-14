import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/player_model.dart';

class PlayerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlayerModel>> getPlayersByClubAndPosition({
    required String clubName,
    required String position,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('players')
          .where('club', isEqualTo: clubName)
          .where('position', isEqualTo: position)
          .orderBy('price', descending: true) // Trie par prix décroissant
          .get();

      return querySnapshot.docs.map((doc) {
        return PlayerModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Erreur lors de la récupération des joueurs : $e");
      return [];
    }
  }
}
