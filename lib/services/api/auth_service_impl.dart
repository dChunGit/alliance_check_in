
import 'package:alliance_tech_check_in/config/secrets.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/services/api/auth_service.dart';
import 'package:alliance_tech_check_in/services/api/auth_storage_service.dart';
import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServiceImpl implements AuthService {
  final SharedPreferences _sharedPreferences;

  AuthServiceImpl()
    : _sharedPreferences = sl();

  CognitoUserPool _userPool = new CognitoUserPool(
      userPoolId,
      clientId
  );

  CognitoUser _cognitoUser;
  CognitoUserSession _session;
  CognitoCredentials credentials;

  Future<bool> init() async {
    _userPool.storage = AuthStorageService(_sharedPreferences);

    _cognitoUser = await _userPool.getCurrentUser();
    if (_cognitoUser == null) {
      return false;
    }
    _session = await _cognitoUser.getSession();
    return _session.isValid();
  }
  
  Future<CognitoCredentials> getCredentials() async {
    if (_cognitoUser == null || _session == null) {
      return null;
    }
    
    credentials = CognitoCredentials(identityPoolId, _userPool);
    await credentials.getAwsCredentials(_session.getIdToken().getJwtToken());
    return credentials;
  }

  Future<String> getToken() async {
    return _session.getIdToken().getJwtToken();
  }

  Future<AuthState> signIn(String username, String password) async {
    _cognitoUser = new CognitoUser(username, _userPool, storage: _userPool.storage);

    final authDetails = new AuthenticationDetails(username: username, password: password);

    try {
      _session = await _cognitoUser.authenticateUser(authDetails);
      return AuthState.VALID_LOGIN;
    } on CognitoUserNewPasswordRequiredException catch (e) {
      print(e);
      return AuthState.NEW_PASSWORD;
    } on CognitoClientException catch (e) {
      print(e);
      return AuthState.INVALID_LOGIN;
    } catch (e) {
      print(e);
      return AuthState.ERROR;
    }
  }

  Future<void> signOut() async {
    if (credentials != null) {
      await credentials.resetAwsCredentials();
    }
    if (_cognitoUser != null) {
      return _cognitoUser.signOut();
    }
  }

  Future<AuthState> setPassword(String password) async {
    if (_cognitoUser == null) {
      return AuthState.ERROR;
    }

    try {
      _session = await _cognitoUser.sendNewPasswordRequiredAnswer(password);
    }
    catch (e) {
      print(e);
      return AuthState.ERROR;
    }

    return AuthState.VALID_LOGIN;
  }

  Future<bool> forgotPassword(String username) async {
    _cognitoUser = new CognitoUser(username, _userPool);

    try {
      _cognitoUser.forgotPassword();
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> resetPassword(String confirmationCode, String newPassword) async {
    if (_cognitoUser == null) {
      return false;
    }

    bool passwordReset;
    try {
      passwordReset = await _cognitoUser.confirmPassword(confirmationCode, newPassword);
    } catch (e) {
      print(e);
    }

    return passwordReset;
  }
}


enum AuthState {
  NEW_PASSWORD,
  VALID_LOGIN,
  INVALID_LOGIN,
  FORGOT_PASSWORD,
  ERROR
}