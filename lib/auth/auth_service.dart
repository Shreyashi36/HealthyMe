import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Error creating user: ${e.toString()}"); // Better error logging
      return null;
    }
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Error logging in: ${e.toString()}");
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      log("User signed out successfully");
    } catch (e) {
      log("Error signing out: ${e.toString()}");
    }
  }
}
