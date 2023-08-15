import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:location_fetch/timer/timer_vm.dart';

class TimerView extends GetView<TimerVm> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Obx(() => Center(
            child: Text('${controller.time.value}'),
          )),
    );
  }
}
