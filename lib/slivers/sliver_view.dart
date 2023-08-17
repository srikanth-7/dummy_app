import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SliverView extends StatelessWidget {
  const SliverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
                child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.black12,
                  child: const Text("data"),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  color: Colors.black12,
                  child: const Text("hjasdhahdkah"),
                )
              ],
            )),
            StickySliver(
              child: Container(
                height: 400,
                color: Colors.purple,
              ),
            ),
            ...List<int>.generate(4, (index) => index).map(
              (e) => SliverToBoxAdapter(
                child: Container(
                    height: 300,
                    color: Colors.yellow,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RenderStickySliver extends RenderSliverSingleBoxAdapter {
  RenderStickySliver({RenderBox? child}) : super(child: child);

  @override
  void performLayout() {
    var myCurrentConstraints = constraints;

    geometry = SliverGeometry.zero;

    child?.layout(
      myCurrentConstraints.asBoxConstraints(),
      parentUsesSize: true,
    );

    double childExtent = child?.size.height ?? 0;
    geometry = SliverGeometry(
      paintExtent: childExtent,
      maxPaintExtent: childExtent,
      paintOrigin: myCurrentConstraints.scrollOffset,
    );

    setChildParentData(child!, myCurrentConstraints, geometry!);
  }
}

class StickySliver extends SingleChildRenderObjectWidget {
  const StickySliver({Widget? child, Key? key}) : super(child: child, key: key);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderStickySliver();
  }
}
