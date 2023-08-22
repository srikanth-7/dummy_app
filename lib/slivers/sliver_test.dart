import 'package:flutter/material.dart';

class SliversView extends StatefulWidget {
  const SliversView({super.key});

  @override
  State<SliversView> createState() => _SliversViewState();
}

class _SliversViewState extends State<SliversView>
    with TickerProviderStateMixin {
  TabController? _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
// TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  Widget _showSelected() {
    Widget selected = const SizedBox();

    switch (selectedIndex) {
      case 0:
        selected = SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (context, index) => Card(
                    margin: const EdgeInsets.all(10),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text("tab data $index")))));
        break;
      case 1:
        selected = SliverList(
            delegate: SliverChildBuilderDelegate(
                childCount: 20, (context, index) => Text("tab 2 data $index")));
        break;
    }
    return selected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              topWidget(),
              stickyWidget(),
              _showSelected(),
            ],
          ),
        ));
  }

  SliverAppBar stickyWidget() {
    return SliverAppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        background: TabBar(
          tabs: [
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.redAccent, width: 1)),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("APPS"),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.redAccent, width: 1)),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("MOVIES"),
                ),
              ),
            ),
          ],
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.redAccent),
          unselectedLabelColor: const Color(0xffacb3bf),
          labelColor: Colors.black,
          controller: _tabController,
          onTap: (value) => setState(() {
            selectedIndex = value;
          }),
        ),
      ),
    );
  }

  SliverToBoxAdapter topWidget() {
    return SliverToBoxAdapter(
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
        ),
      ],
    ));
  }
}
