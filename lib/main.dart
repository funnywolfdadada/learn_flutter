import 'package:flutter/material.dart';
import 'package:learn_flutter/simple_demo.dart';

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
  "simple_demo": (context) => SimpleDemoPage()
};

final routeMapKey = routeMap.keys.toList();

class HomePage extends StatelessWidget {
  final List<_PageEntryItem> _pages = [
    _PageEntryItem("Simple Demo Page", "A simple demo page contains ListView", routeMapKey[0]),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
    _PageEntryItem("111", "222", "333"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _buildPageEntry(context, _pages[index]);
        },
        itemCount: _pages.length,
      ),
    );
  }

  _buildPageEntry(BuildContext context, _PageEntryItem item) {
    return Card(
      child: FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, item.url, arguments: item.title);
        },
        child: Column(
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
    );
  }

}

class _PageEntryItem {
  String title;
  String desc;
  String url;
  _PageEntryItem(this.title, this.desc, this.url);
}