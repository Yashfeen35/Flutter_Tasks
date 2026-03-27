import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential> login(String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Register a new user
  Future<UserCredential> register(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  // Send password reset email
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Currently signed in user (nullable)
  User? get currentUser => _auth.currentUser;
}
