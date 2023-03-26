import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elredtodo/app/core/utils/constant.dart';
import 'package:elredtodo/app/data/services/apiconstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?>? get user {
    return _auth.authStateChanges();
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }

  Future<User?> get currentUser async {
    return _auth.currentUser;
  }

  // GoogleSignIn
  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential).then((value) =>
          FirebaseFirestore.instance
              .collection('userdata')
              .doc(value.user?.uid)
              .set({
            'email': value.user?.email,
            'uid': value.user?.uid,
          }));
    } catch (e) {
      ScaffoldMessenger.of(navigatorKey.currentContext as BuildContext)
          .showSnackBar(const SnackBar(content: Text("Google SignIn Failed")));
    }
  }
}
