import 'package:flutter/material.dart';
import 'package:learn_flutter/scroll_widgets.dart';
import 'package:learn_flutter/simple_demo.dart';

import 'basic_widgets.dart';
import 'container_widgets.dart';
import 'functional_widgets.dart';
import 'layout_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: routeMap,
    );
  }
}

final routeMap = {
  "simple_demo": (context) => SimpleDemoPage(),
  "basic_widgets": (context) => BasicWidgetsPage(),
  "layout_widgets": (context) => LayoutWidgetsPage(),
  "container_widgets": (context) => ContainerWidgetsPage(),
  "scroll_widgets": (context) => ScrollWidgetsPage(),
  "functional_widgets": (context) => FunctionalWidgets(),
};

final routeMapKey = routeMap.keys.toList();

class HomePage extends StatelessWidget {
  final List<_PageEntryItem> _pages = [
    _PageEntryItem("Simple Demo", "A simple demo page contains ListView", routeMapKey[0], color: Colors.blue),
    _PageEntryItem("Basic Widgets", "Introduces basic widgets", routeMapKey[1], color: Colors.green),
    _PageEntryItem("Layout Widgets", "Layout widgets test", routeMapKey[2], color: Colors.grey),
    _PageEntryItem("Container Widgets", "Container Widgets", routeMapKey[3], color: Colors.yellow),
    _PageEntryItem("Scroll Widgets", "Scroll Widgets", routeMapKey[4], color: Colors.pink),
    _PageEntryItem("Functional Widgets", "Functional Widgets", routeMapKey[5], color: Colors.purple),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Learn Flutter"),
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.jpg"),
              fit: BoxFit.cover,
            ),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildPageEntry(context, _pages[index]);
          },
          itemCount: _pages.length,
        ),
      ),
    );
  }

  _buildPageEntry(BuildContext context, _PageEntryItem item) {
    return Card(
      color: Color(0x80FFFFFF),
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, item.url, arguments: {
            "title" : item.title,
            "color" : item.color,
          });
        },
        child:Row(
          children: <Widget>[
            Expanded(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(10),
                    child: Text(
                      item.title,
                      style: TextStyle(color: Colors.blue, fontSize: 22),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10),
                    child: Text(
                      item.desc,
                      style: TextStyle(color: Colors.blue, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      )
    );
  }

}

class _PageEntryItem {
  final String title;
  final String desc;
  final String url;
  final Color color;
  _PageEntryItem(this.title, this.desc, this.url, {this.color: Colors.white});
}