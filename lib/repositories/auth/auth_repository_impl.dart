import 'package:alliance_tech_check_in/config/constants.dart';
import 'package:alliance_tech_check_in/locator.dart';
import 'package:alliance_tech_check_in/utils/listeners/auth_listener.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
// TODO: Move to utils and inject instances
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final SharedPreferences _sharedPreferences;

  FirebaseUser _currentUser;

  AuthListener authListener;

  AuthRepositoryImpl()
      : _auth = sl(),
        _googleSignIn = sl(),
        _sharedPreferences = sl();

  void setListener(AuthListener newListener) {
    authListener = newListener;
    _auth.onAuthStateChanged.listen((user) {
      if (user?.isEmailVerified ?? false) {
        _getToken(user).then((token) => authListener.emailVerified(token));
      }
    });
  }

  Future<bool> isLoggedIn() async {
    return _currentUser != null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    if (_currentUser == null) {
      _currentUser = await _auth.currentUser();
    }
    return _currentUser;
  }

  FirebaseUserMetadata getCurrentUserMetadata() {
    if (_currentUser == null) {
      return null;
    }

    return _currentUser.metadata;
  }

  Future<IdTokenResult> registerUser(String name, String email, String password) async {
    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password)).user;
      if (user.isAnonymous || user == null) {
        return null;
      }

      try {
        await user.sendEmailVerification();
      }
      catch (e) {
        print("Error occurred sending email verification");
        return null;
      }

      var userInfo = UserUpdateInfo();
      userInfo.displayName = name;
      await user.updateProfile(userInfo);

      return _getToken(user);
    }
    catch (e) {
      return null;
    }
  }

  Future<IdTokenResult> signInWithEmail(String email, String password) async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;

      if (user.isAnonymous || user == null) {
        return null;
      }

      return _getToken(user);
    }
    catch (e) {
      return null;
    }
  }

  Future<IdTokenResult> signInWithGoogle() async {
    //TODO CLEAN THIS UP
    try {
      final GoogleSignInAccount googleAccount = await _googleSignIn
          .signIn();
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final AuthResult authResult = await _auth.signInWithCredential(
          credential);

      return _getToken(authResult.user);
    }
    catch (e) {
      return null;
    }
  }

  Future<bool> signOutUser() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _sharedPreferences.setBool(loginStateKey, false);
      _currentUser = null;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<IdTokenResult> _getToken(FirebaseUser currentUser) async {
    final token = await currentUser.getIdToken().then((token) {
      print("Token => ${token.token}");
      return token;
    });

    _currentUser = currentUser;

    await _sharedPreferences.setBool(loginStateKey, true);

    return token;
  }
}