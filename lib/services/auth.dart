import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

// interface of AuthBase to use at Auth class as implementation
abstract class AuthBase {
  User get currentUser;
  Stream<User> authStateChanges();
  Future<User> signInAnonymously();
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();

    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));

        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          message: 'Missing Google ID Token',
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
        );
      }
    } else {
      throw FirebaseAuthException(
        message: 'Sign in aborted by user',
        code: 'ERROR_ABORTED_BY_USER',
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));

        return userCredential.user;
        break;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          message: 'Sign in aborted by user',
          code: 'ERROR_ABORTED_BY_USER',
        );

        break;
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          message: response.error.developerMessage,
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
        );
        break;
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    final facebookLogin = FacebookLogin();

    await facebookLogin.logOut();

    await _firebaseAuth.signOut();
  }
}
