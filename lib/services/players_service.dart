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
          .orderBy('price', descending: true)
          .get();

      if (querySnapshot.docs.isEmpty) {
        print("⚠️ No players found for $clubName - $position");
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;

        if (!data.containsKey("name") || !data.containsKey("price")) {
          print("❌ Corrupt document found: ${doc.id}");
          print("Data: $data");
        }

        return PlayerModel.fromJson(data);
      }).toList();
    } catch (e) {
      print("🔥 Firestore Error: $e");
      return [];
    }
  }
  }

