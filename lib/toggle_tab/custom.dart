import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomItems {
  static customTabbar({
    List<Widget> tabs = const [],
    required IndexedWidgetBuilder pageBuilder,
  }) {
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            alignment: Alignment.center,
            child: TabBar(
              indicator: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10.0)),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: tabs,
            ),
          ),
          Expanded(
            child: TabBarView(
                children: List.generate(
                    tabs.length, (index) => pageBuilder(Get.context!, index))),
          )
        ],
      ).marginAll(20),
    );
  }
}
