import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static AuthService instance = AuthService._();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> register({
    required String userEmail,
    required String userPassword,
  }) async {
    String statusMessage;
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      statusMessage = "Success";
    } on FirebaseAuthException catch (e) {
      log("Sign Up Error: ${e.code}");
      switch (e.code) {
        case 'operation-not-allowed':
          statusMessage = 'Try another login method';
        case 'weak-password':
          statusMessage = "Password is too weak 🔒";
        case 'email-already-in-use':
          statusMessage = "Email already exists";
        default:
          statusMessage = e.code;
      }
    }

    return statusMessage;
  }

  Future<String> login({
    required String userEmail,
    required String userPassword,
  }) async {
    String statusMessage;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      statusMessage = "Success";
    } on FirebaseAuthException catch (e) {
      log("Login Error: ${e.code}");

      switch (e.code) {
        case 'invalid-credential':
          statusMessage = "Invalid email or password";
        case 'operation-not-allowed':
          statusMessage = 'Try another login method';
        default:
          statusMessage = e.code;
      }
    }

    return statusMessage;
  }

  Future<String> loginWithGoogle() async {
    String statusMessage;
    try {
      GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        var credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        await firebaseAuth.signInWithCredential(credential);

        statusMessage = "Success";
      } else {
        statusMessage = "No Google Account selected";
      }
    } on FirebaseAuthException catch (e) {
      statusMessage = e.code;
    }
    return statusMessage;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  User? get currentUser => firebaseAuth.currentUser;
}
