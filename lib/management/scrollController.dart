import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Used for the animation button, give to the varius page in main/app
class ScrollControllerHome extends GetxController {
  final ScrollController controller = ScrollController();
  RxBool isScrolled = false.obs;

  void initcontroller() {
    controller.addListener(() {
      if (controller.offset > 50)
        isScrolled.value = true;
      else
        isScrolled.value = false;
    });

    update();
  }
}
