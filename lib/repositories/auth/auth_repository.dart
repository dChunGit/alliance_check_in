import 'package:alliance_tech_check_in/utils/listeners/auth_listener.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  void setListener(AuthListener newListener);
  Future<bool> isLoggedIn();
  Future<FirebaseUser> getCurrentUser();
  Future<IdTokenResult> registerUser(String name, String email, String password);
  Future<IdTokenResult> signInWithEmail(String email, String password);
  Future<IdTokenResult> signInWithGoogle();
  Future<bool> signOutUser();
  Future<void> resetPassword(String email);
  FirebaseUserMetadata getCurrentUserMetadata();
}