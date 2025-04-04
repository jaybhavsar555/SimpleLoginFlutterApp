import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> login(String email, String password){
    return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }


  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return "Invalid email format. Please check your email.";
      case 'user-not-found':
        return "No account found with this email. Please sign up first.";
      case 'wrong-password':
        return "Incorrect password. Try again or reset your password.";
      case 'too-many-requests':
        return "Too many failed attempts. Please try again later.";
      case 'user-disabled':
        return "User with this email has been disabled.";
      case 'operation-not-allowed':
        return "Signing in with Email and Password is not enabled.";
        case 'invalid-credential':
          return 'Invalid email or password. Please double-check your credentials.';
      default:
        debugPrint('Unhandled FirebaseAuth error: $errorCode');
        return "Login failed. Please try again.";
    }
  }
}