import 'dart:math';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class SimpleDemoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SimpleDemoPageState();
  }

}

class _SimpleDemoPageState extends State<SimpleDemoPage> {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    var title = args["title"];
    var color = args["color"];
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return _getCardWithIndex(index);
        },
        itemCount: 22,
      ),
    );
  }

}

_getCardWithIndex(int index) {
  return Container(
    child: Card(
      child: FlatButton(
        onPressed: () { print("点击了 $index 哦"); },
        child: Padding(
          padding: EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Text(
                  "这是一点描述：${WordPair.random().toString()}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: new EdgeInsets.only(top: 6.0, bottom: 2.0),
                alignment: Alignment.topLeft
              ),
              Padding(padding: EdgeInsets.only(top: 6, bottom: 2)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _getBottomItem(Icons.star, Random().nextInt(1000).toString()),
                  _getBottomItem(Icons.link, Random().nextInt(1000).toString()),
                  _getBottomItem(Icons.subject, Random().nextInt(1000).toString()),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

_getBottomItem(IconData icon, String text) {
  return Expanded(
    flex: 1,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 16,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.5),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}