import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimationViewModel extends GetxController {
  late PageController pageController;
  RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    pageController = PageController()
      ..addListener(() {
        debugPrint("called ${pageController.page}");
        progress.value =
            pageController.hasClients ? pageController.page ?? 0 : 0;
        update();
      });

    //
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    progress.value = 0.0;
    super.onClose();
  }
}
