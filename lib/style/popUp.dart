import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class MainPopUpStyle {
  static flashPopUpDone({
    String title = "",
    required BuildContext context,
  }) {
    return showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          onTap: () => controller.dismiss(),
          backgroundColor: Colors.green,
          margin: EdgeInsets.symmetric(vertical: 70),
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInOut,
          borderRadius: BorderRadius.circular(30),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.done_sharp, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }

  static flashPopUpError({
    String msg = "",
    required BuildContext context,
  }) {
    return showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (context, controller) {
        return Flash(
          controller: controller,
          onTap: () => controller.dismiss(),
          backgroundColor: Colors.redAccent,
          margin: EdgeInsets.symmetric(vertical: 70),
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          forwardAnimationCurve: Curves.easeInOut,
          borderRadius: BorderRadius.circular(30),
          horizontalDismissDirection: HorizontalDismissDirection.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  msg,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.error_outline_outlined, color: Colors.white),
              ],
            ),
          ),
        );
      },
    );
  }
}
