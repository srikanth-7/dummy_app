import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_fetch/toggle_tab/custom.dart';
import 'package:location_fetch/toggle_tab/toggle_tab_viewmodel.dart';

class ToggleTabBarView extends GetView<ToggleTabViewModel> {
  const ToggleTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomItems.customTabbar(
          tabs: controller.tabViews,
          pageBuilder: (context, index) => controller.tabViews[index],
        ),
      ),
    );
  }
} 
// import 'package:flutter/material.dart';

// class ToggleTabBarView extends StatefulWidget {
//   const ToggleTabBarView({super.key});

//   @override
//   ToggleTabBarViewState createState() => ToggleTabBarViewState();
// }

// class ToggleTabBarViewState extends State<ToggleTabBarView> {
//   List<String> data = ['Page 0', 'Page 1', 'Page 2'];
//   int initPosition = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: CustomTabView(
//           initPosition: initPosition,
//           itemCount: data.length,
//           tabBuilder: (context, index) => Tab(text: data[index]),
//           pageBuilder: (context, index) => Center(child: Text(data[index])),
//           onPositionChange: (index) {
//             print('current position: $index');
//             initPosition = index;
//           },
//           onScroll: (position) => print('$position'),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             data.add('Page ${data.length}');
//           });
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class CustomTabView extends StatefulWidget {
//   const CustomTabView({
//     super.key,
//     required this.itemCount,
//     required this.tabBuilder,
//     required this.pageBuilder,
//     this.stub,
//     this.onPositionChange,
//     this.onScroll,
//     this.initPosition,
//   });

//   final int itemCount;
//   final IndexedWidgetBuilder tabBuilder;
//   final IndexedWidgetBuilder pageBuilder;
//   final Widget? stub;
//   final ValueChanged<int>? onPositionChange;
//   final ValueChanged<double>? onScroll;
//   final int? initPosition;

//   @override
//   CustomTabsState createState() => CustomTabsState();
// }

// class CustomTabsState extends State<CustomTabView>
//     with TickerProviderStateMixin {
//   late TabController controller;
//   late int _currentCount;
//   late int _currentPosition;

//   @override
//   void initState() {
//     _currentPosition = widget.initPosition ?? 0;
//     controller = TabController(
//       length: widget.itemCount,
//       vsync: this,
//       initialIndex: _currentPosition,
//     );
//     controller.addListener(onPositionChange);
//     controller.animation!.addListener(onScroll);
//     _currentCount = widget.itemCount;
//     super.initState();
//   }

//   @override
//   void didUpdateWidget(CustomTabView oldWidget) {
//     if (_currentCount != widget.itemCount) {
//       controller.animation!.removeListener(onScroll);
//       controller.removeListener(onPositionChange);
//       controller.dispose();

//       if (widget.initPosition != null) {
//         _currentPosition = widget.initPosition!;
//       }

//       if (_currentPosition > widget.itemCount - 1) {
//         _currentPosition = widget.itemCount - 1;
//         _currentPosition = _currentPosition < 0 ? 0 : _currentPosition;
//         if (widget.onPositionChange is ValueChanged<int>) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             if (mounted && widget.onPositionChange != null) {
//               widget.onPositionChange!(_currentPosition);
//             }
//           });
//         }
//       }

//       _currentCount = widget.itemCount;
//       setState(() {
//         controller = TabController(
//           length: widget.itemCount,
//           vsync: this,
//           initialIndex: _currentPosition,
//         );
//         controller.addListener(onPositionChange);
//         controller.animation!.addListener(onScroll);
//       });
//     } else if (widget.initPosition != null) {
//       controller.animateTo(widget.initPosition!);
//     }

//     super.didUpdateWidget(oldWidget);
//   }

//   @override
//   void dispose() {
//     controller.animation!.removeListener(onScroll);
//     controller.removeListener(onPositionChange);
//     controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (widget.itemCount < 1) return widget.stub ?? Container();

//     return Column(
//       // crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[300],
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           child: TabBar(
//             isScrollable: true,
//             controller: controller,
//             indicator: BoxDecoration(
//                 color: Colors.blueAccent,
//                 borderRadius: BorderRadius.circular(10.0)),
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.black,
//             tabs: List.generate(
//               widget.itemCount,
//               (index) => widget.tabBuilder(context, index),
//             ),
//           ),
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: controller,
//             children: List.generate(
//               widget.itemCount,
//               (index) => widget.pageBuilder(context, index),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void onPositionChange() {
//     if (!controller.indexIsChanging) {
//       _currentPosition = controller.index;
//       if (widget.onPositionChange is ValueChanged<int>) {
//         widget.onPositionChange!(_currentPosition);
//       }
//     }
//   }

//   void onScroll() {
//     if (widget.onScroll is ValueChanged<double>) {
//       widget.onScroll!(controller.animation!.value);
//     }
//   }
// }
