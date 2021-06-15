import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay_split/models/UserModel.dart';

class AuthenticationService {
  final FirebaseAuth _auth;

  AuthenticationService(this._auth);

  Future<String> signUp(String email, String password) async {
    print("Email $email Password $password");
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "Weak password";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "Account exists";
      }
    } catch (e) {
      print(e);
      return "";
    }
    return "";
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(msg: "Wrong Credentials");
        return "No user found";
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Wrong Password");
        print('Wrong password provided for that user.');
        return "Wrong password";
      }
    }
    return "";
  }

  Future<String> signOut() async {
    try {
      await _auth.signOut();
      return "Signed Out";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "No user found";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "Wrong password";
      }
    }
    return "";
  }
}