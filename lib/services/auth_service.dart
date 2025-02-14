import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 🔹 **Inscription avec email & mot de passe**
  Future<String?> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Succès (pas d'erreur)
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "An unexpected error occurred.";
    }
  }

  /// 🔹 **Connexion avec email & mot de passe**
  Future<String?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Succès
    } on FirebaseAuthException catch (e) {
      return _handleAuthError(e);
    } catch (e) {
      return "An unexpected error occurred.";
    }
  }

  /// 🔹 **Déconnexion**
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// 🔹 **Récupérer l'utilisateur actuellement connecté**
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// 🔹 **Gérer les erreurs Firebase**
  String _handleAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return "This email is already in use.";
      case 'weak-password':
        return "The password is too weak.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Incorrect password.";
      default:
        return "An error occurred. Please try again.";
    }
  }
}
