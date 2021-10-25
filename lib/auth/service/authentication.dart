import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:levant/auth/service/getRoute.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  // final database = Db();
  final FacebookLogin facebookLogin = FacebookLogin();
  // final profileData = Get.put(UserProfile());

  Future allAuthentication(
      String provider, Map data, BuildContext context) async {
    var account; // UserCredential

    try {
      switch (provider) {
        case "Google":
          account = await signInWithGoogle();
          break;
        case "Facebook":
          account = await signInWithFacebook();
          break;
        case "Login":
          account = await login(data["Email"], data["Password"]);
          break;
        case "SignUp":
          account = await signup(data["Email"], data["Password"], data["Name"]);
          break;
      }
    } catch (e) {
      account = "Error unexpected try again";
    }

    if (account != null && account is! String) {
      final Widget route = await GetRoute.getRouteInit();

      // Go to the specific route
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => route), (route) => false);
    } else {
      if (account != null) dialogErrorAuth(value: account, context: context);
      return null;
    }
  }

  Future dialogErrorAuth({String value = "", required BuildContext context}) {
    print("######### AUTHENTICATION ERROR:\n$value");

    return showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(title: Text("Errore"), content: Text(value)));
  }

  // Future sendEmailConfirmation() async {
  //   await auth.currentUser.sendEmailVerification();
  // }

  // Future<bool> resetPassword(String email, BuildContext context) async {
  //   try {
  //     await auth.sendPasswordResetEmail(email: email);
  //     return true;
  //   } catch (e) {
  //     dialogErrorAuth(value: e.message, context: context);
  //     return false;
  //   }
  // }

  //#region Auth-social
  Future signInWithGoogle() async {
    // Authentication init
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final result = await googleSignIn.signIn();
    if (result == null) return; // If go back return

    // Authentication values
    final GoogleSignInAuthentication googleSignInAuthentication =
        await result.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Authentication with firebase with google provider
    try {
      final UserCredential account =
          await auth.signInWithCredential(credential);
      return account.user;
    } catch (e) {
      print(e);
      return null; // Some Errors
    }
  }

  //log in with Facebook
  Future signInWithFacebook() async {
    final result = await facebookLogin.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        final credential = FacebookAuthProvider.credential(accessToken.token);
        final account = await auth.signInWithCredential(credential);
        return account.user;
      case FacebookLoginStatus.cancelledByUser:
        print("Cancel");
        return null;
      case FacebookLoginStatus.error:
        print("Error: " + result.errorMessage);
        return result.errorMessage;
    }
  }
  //#endregion

  //#region Signup/Login with credential
  Future login(String email, String password) async {
    try {
      final account = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return account.user;
    } catch (e) {
      return e;
    }
  }

  Future signup(
    String email,
    String password,
    String name,
  ) async {
    try {
      UserCredential account = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser!.updateDisplayName(name);
      return account.user;
    } catch (e) {
      return e;
    }
  }
  //#endregion
}
