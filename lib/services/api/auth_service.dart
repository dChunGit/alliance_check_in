import 'package:alliance_tech_check_in/services/api/auth_service_impl.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';

abstract class AuthService{
  Future<bool> init();
  Future<AuthState> signIn(String username, String password);
  Future<void> signOut();
  Future<AuthState> setPassword(String password);
  Future<bool> forgotPassword(String username);
  Future<bool> resetPassword(String confirmationCode, String newPassword);
  Future<CognitoCredentials> getCredentials();
  Future<String> getToken();
}