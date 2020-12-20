import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';

class AuthServiceImpl {
  Future<AuthNextSignInStep> signIn(String username, String password) async {
    try {
      SignInResult result = await Amplify.Auth.signIn(username: username, password: password);
      return result.nextStep;
    } on AuthError catch (e) {
      print(e);
      return null;
    }
  }
}