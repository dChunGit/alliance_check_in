import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthListener {
  void emailVerified(IdTokenResult token);
}