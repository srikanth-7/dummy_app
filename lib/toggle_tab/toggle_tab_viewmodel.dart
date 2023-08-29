import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleTabViewModel extends GetxController {
  List<Widget> tabViews = [
    const Center(
      child: Text("Chats"),
    ),
    Container(
      child: const Text("Status"),
    ),
    Container(
      child: const Text("Calls"),
    ),
    Container(
      child: const Text("Settings"),
    ),
  ];
  var tabs = [
    const Tab(
      child: Text(
        "Chats",
        textAlign: TextAlign.center,
      ),
      // text: 'Chats',
    ),
    const Tab(
      child: Text(
        "Status",
        textAlign: TextAlign.center,
      ),
    ),
    const Tab(
      child: Text(
        "Calls",
        textAlign: TextAlign.center,
      ),
    ),
    const Tab(
      child: Text(
        "Settings",
        textAlign: TextAlign.center,
      ),
    )
  ];
}
