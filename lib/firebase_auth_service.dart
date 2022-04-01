library firebase_auth_service;

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges();
  }

  static Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  static User? get currentUser => _firebaseAuth.currentUser;

  static Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}
