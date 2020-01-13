import 'package:flutter/material.dart';
import 'package:learn_flutter/simple_demo.dart';

class TabHome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabBarWidget([
      TabItem(Text("Tab 1", style: TextStyle(fontSize: 20),), ListViewTestWidget(12)),
      TabItem(Text("Tab 2", style: TextStyle(fontSize: 20),), ListViewTestWidget(22)),
      TabItem(Text("Tab 3", style: TextStyle(fontSize: 20),), ListViewTestWidget(32)),
    ]);
  }

}

class TabItem {
  Widget tab;
  Widget page;

  TabItem(this.tab, this.page);
}

class TabBarWidget extends StatefulWidget {

  final List<TabItem> _tabItems;

  TabBarWidget(this._tabItems);

  @override
  State<StatefulWidget> createState() {
    return _TabBarState(_tabItems);
  }

}

class _TabBarState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  final List<TabItem> _tabItems;

  TabController _tabController;
  PageController _pageController;

  _TabBarState(this._tabItems);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabItems.length, vsync: this);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _createPageView(),
      bottomNavigationBar: _createTabBar(),
    );
  }

  Widget _createTabBar() {
    return TabBar(
      tabs: List.generate(_tabItems.length, (index) => FlatButton(
        onPressed: () => _pageController.jumpToPage(index),
        child: _tabItems[index].tab,
      )),
      controller: _tabController,
    );
  }

  Widget _createPageView() {
    return PageView(
      controller: _pageController,
      children: List.generate(_tabItems.length, (index) => _tabItems[index].page),
      onPageChanged: (index) => _tabController.animateTo(index),
    );
  }

}
