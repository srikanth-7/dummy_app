import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:get/get.dart';
import 'package:location_fetch/animation/animation_view.dart';
import 'package:location_fetch/button/buttonviewmodel.dart';
import 'package:location_fetch/button/progress.dart';
import 'package:location_fetch/maps/maps_view.dart';
import 'package:location_fetch/timer/timer.dart';
import 'package:location_fetch/toggle_tab/toggle_tab_view.dart';

import '../slivers/sliver_test.dart';
import '../slivers/sliver_view.dart';

// ignore: must_be_immutable
class GetLocationView extends StatelessWidget {
  GetLocationView({super.key});
  ViewModel ctrlr = Get.put(ViewModel());

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  Widget build(BuildContext context) {
    ctrlr.determinePosition();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton.icon(
                label: const Text("Show Progress bar"),
                onPressed: () async {
                  CustomProgressIndicator.openLoadingDialog();
                  Future.delayed(const Duration(seconds: 1), () {
                    CustomProgressIndicator.closeLoadingOverlay();
                  });
                },
                icon: const Icon(Icons.recycling)),
            TextButton.icon(
                label: const Text("Get Distance"),
                onPressed: () async {
                  var data = await ctrlr.getDist();
                  debugPrint(":aslkdf ${data / 1000}");
                  double totalDistance = ctrlr.calculateDistance(
                      ctrlr.lat.value,
                      ctrlr.lng.value,
                      ctrlr.apiLat.value,
                      ctrlr.apiLng.value);
                  print(totalDistance);
                  Get.snackbar("The distance is $totalDistance", "");
                  ctrlr.getDistance();
                },
                icon: const Icon(Icons.navigation_outlined)),
            TextButton.icon(
                onPressed: () async {
                  Get.to(() => TimerView(),
                      transition: Transition.circularReveal,
                      curve: Curves.easeInOut);
                },
                label: const Text("Switch on the Timer"),
                icon: const Icon(Icons.timer)),
            TextButton.icon(
                onPressed: () async {
                  return showModalBottomSheet(
                    // isScrollControlled: true,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                    context: context,
                    // enableDrag: false,
                    showDragHandle: true,
                    enableDrag: true,
                    constraints: BoxConstraints.loose(Size(
                        MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height * 0.9)),
                    builder: (context) => WillPopScope(
                      onWillPop: () async => false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        // width: Get.width,
                        child: withScaffold(),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.vertical_align_bottom_sharp),
                label: const Text("Open BottomSheet")),
            TextButton.icon(
                label: const Text("show map"),
                onPressed: () async {
                  Get.to(const MapScreen());
                },
                icon: const Icon(Icons.recycling)),
            GestureDetector(
              onTap: () => Get.to(const PageAnimationView()),
              child: const Chip(
                label: Text("jjdjd"),
                avatar: Icon(Icons.add),
              ),
            ),
            TextButton.icon(
                label: const Text("show sliver test sticky header"),
                onPressed: () async {
                  // Get.to(const SliverView());
                  Get.to(const SliversView());
                },
                icon: const Icon(Icons.sledding_outlined)),
            TextButton.icon(
                label: const Text("show sliver sticky header"),
                onPressed: () async {
                  Get.to(const SliverView());
                  // Get.to(const SliversView());
                },
                icon: const Icon(Icons.sledding_outlined)),
            TextButton.icon(
                label: const Text("show Tabbar"),
                onPressed: () async {
                  Get.to(const ToggleTabBarView());
                  // Get.to(const SliversView());
                },
                icon: const Icon(Icons.tab)),
            TextButton.icon(
                label: const Text("show snackbar"),
                onPressed: () async {
                  // Flushbar().show(Get.context!);
                },
                icon: const Icon(Icons.touch_app_sharp)),
          ],
        ),
      ),
    );
  }

  Scaffold withScaffold() {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Wrap(children: [
          ...List.generate(
            10,
            (index) => FilterChip(
                padding: const EdgeInsets.all(10),
                label: Text(getRandomString(index > 10 ? index - 9 : index)),
                onSelected: (bool selected) {}),
          )
        ]),
      ),
      bottomNavigationBar: sheetButton(),
    );
  }

  Container sheetButton() {
    return Container(
      color: Colors.green[100],
      padding: const EdgeInsets.all(15),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        onPressed: () {},
        child: const Text('Elevated Button'),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      primary: false,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Title",
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.w800),
          ),
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ))
        ],
      ),
    );
  }
}
