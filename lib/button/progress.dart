import "package:flutter/material.dart";

import "package:get/get.dart";

class CustomProgressIndicator {
  static bool isShowing = false;

  static Future<void> closeLoadingOverlay() async {
    if (CustomProgressIndicator.isShowing) {
      Navigator.of(Get.overlayContext ?? Get.context!).pop();
      CustomProgressIndicator.isShowing = false;
      await Future<dynamic>.delayed(const Duration(microseconds: 200));
    }
  }

  static Future<void> openLoadingDialog() async {
    if (!CustomProgressIndicator.isShowing && !Get.isSnackbarOpen) {
      CustomProgressIndicator.isShowing = true;
      showDialog(
        context: Get.overlayContext ?? Get.context!,
        barrierDismissible: false,
        useSafeArea: false,
        builder: (_) => const LoadingOverlay(),
      );
    }
  }
}

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200000),
      lowerBound: 10,
      upperBound: 20,
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          // height: Get.context?.height ?? Get.height,
          height: 100,
          // width: Get.context?.width ?? Get.width,
          width: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator.adaptive(),
              RotationTransition(
                turns:
                    Tween<double>(begin: 0.0, end: 10.0).animate(_controller),
                child: Center(
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints boxConstraints) {
                      if (Get.context?.isTablet ?? Get.width >= 700) {
                        return SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(Icons.ac_unit_rounded),
                        );
                      } else {
                        return SizedBox(
                          height: 30,
                          width: 30,
                          child: Icon(Icons.access_alarm_sharp),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
