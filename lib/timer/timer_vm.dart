import 'dart:async';

import 'package:get/get.dart';

class TimerVm extends GetxController {
  Timer? _timer;
  int remT = 1;
  final time = '00.00'.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    _startTimer(90);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  void _startTimer(int i) {
    const duration = Duration(seconds: 1);
    remT = i;
    _timer = Timer.periodic(duration, (timer) {
      if (remT == 0) {
        _timer!.cancel();
      } else {
        int min = remT ~/ 60;
        int sec = remT % 60;
        time.value = min.toString().padLeft(2, "0") +
            ":" +
            sec.toString().padLeft(2, '0');
        remT--;
      }
    });
  }
}
