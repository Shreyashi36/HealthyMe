import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<UserCredential?> loginWithGoogle() async {
  //   try {
  //     final googleUser = await GoogleSignIn().signIn();

  //     final googleAuth = await googleUser?.authentication;

  //     final cred = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //     return await _auth.signInWithCredential(cred);
  //   } catch (e) {
  //     log(e.toString());
  //   }
  //   return null;
  // }

  Future<void> sendEmailVerificationLink() async {
    try {
      final user = _auth.currentUser;
      await user!.sendEmailVerification();
      log("Email verification link sent");
    } catch (e) {
      log("Error sending email verification link: ${e.toString()}");
    }
  }

  Future<void> sendPasswordResetLink(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      log("Email verification link sent");
    } catch (e) {
      log("Error sending email verification link: ${e.toString()}");
    }
  }

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
