import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<User> get user {
    return _auth.authStateChanges();
  }

  User getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  Future registerWithEmailAndPassword({emailid, password}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: emailid, password: password);
      return result;
    } catch (error) {
      throw error;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future signInWithGoogle() async {
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final authCreds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final user = (await _auth.signInWithCredential(authCreds)).user;
      return user;
    } catch (error) {
      print(error.toString());
      throw error;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
      await googleSignIn.signOut();
    } catch (error) {
      print(error.toString());
    }
  }

  void deleteUser() {
    try {
      final user = _auth.currentUser;
      user.delete();
    } catch (e) {
      print(e);
    }
  }

  signIn(AuthCredential authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }
}
