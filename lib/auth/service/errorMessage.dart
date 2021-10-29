import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialogComponent {
  static final _message = {
    "There is no user record corresponding to this identifier. The user may have been deleted.":
        "Non esiste nessun utente associato a questa email",
    'The password is invalid or the user does not have a password.':
        'La password è errata',
    'The email address is already in use by another account.':
        'Questa email è già in uso su un altro account',
  };

  static String getMessage(String key) {
    return _message[key] ??
        "Ops... qualcosa è andato storto. Riprova più tardi";
  }

  static Future dialogError(
      {required String msg, required BuildContext context}) {
    return showFlash(
      context: context,
      duration: Duration(seconds: 5),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          onTap: () => controller.dismiss(),
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(15),
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInOut,
          borderRadius: BorderRadius.circular(17),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              getMessage(msg),
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
