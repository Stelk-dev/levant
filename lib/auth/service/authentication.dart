import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:levant/auth/service/errorMessage.dart';
import 'package:levant/main/app.dart';
import 'package:levant/model/modelAccount/db_profile.dart';
import 'package:levant/model/modelAccount/profile.dart';
import 'package:levant/database/database.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final database = Db();
  final FacebookLogin facebookLogin = FacebookLogin();
  final profile = Get.put(Profile());

  String idDb() {
    if (auth.currentUser == null)
      return "0";
    else
      return auth.currentUser!.uid.hashCode.toString();
  }

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

    if (account != null && account is User) {
      String name = account.displayName ?? data["Name"];
      final databaseProfileModel = DatabaseProfileModel(
        name: name,
        email: account.email!,
        img: account.photoURL!,
        uid: idDb(),
        tickets: Map<String, List>.from({"Biglietti": [], "Code": []}),
      );

      final existProfile = await database.userExist(uid: idDb());
      if (!existProfile)
        await database.creationDb(idDb(), databaseProfileModel.toJson());

      profile.initProfile(data: databaseProfileModel);
      profile.printDataProfile();

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => App(existProfile: existProfile)),
        (route) => false,
      );
    } else {
      if (account != null) dialogErrorAuth(value: account, context: context);
      return null;
    }
  }

  Future dialogErrorAuth({String value = "", required BuildContext context}) {
    print("#########??AUTHENTICATION ERROR:\n$value");

    return ErrorDialogComponent.dialogError(msg: value, context: context);
  }

  // Future sendEmailConfirmation() async {
  //   await auth.currentUser.sendEmailVerification();
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
      FirebaseAuthException msg = e as FirebaseAuthException;
      return msg.message;
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
        return null;
      case FacebookLoginStatus.error:
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
      FirebaseAuthException msg = e as FirebaseAuthException;
      return msg.message;
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
      FirebaseAuthException msg = e as FirebaseAuthException;
      return msg.message;
    }
  }
  //#endregion
}
