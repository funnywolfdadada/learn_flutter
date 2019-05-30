import 'package:flutter/material.dart';

class LayoutWidgetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    var title = args["title"];
    var color = args["color"];
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: Text(title),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _LinearLayoutWidgets(),
            _FlexLayoutWidgets(),
          ],
        ),
      ),
    );
  }
}

class _LinearLayoutWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("MainAxisAlignment"),
              Text(" start"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("MainAxisAlignment"),
              Text(" center"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text("MainAxisAlignment"),
              Text(" end"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            children: <Widget>[
              Text("CrossAxisAlignment.start", style: TextStyle(fontSize: 20.0),),
              Text(" VerticalDirection.up", style: TextStyle(fontSize: 10.0),)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Text("CrossAxisAlignment.start", style: TextStyle(fontSize: 20.0),),
              Text(" VerticalDirection.down", style: TextStyle(fontSize: 10.0),)
            ],
          ),
        ],
      ),
    );
  }
}

class _FlexLayoutWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(height: 30, color: Colors.red,),
              ),
              Expanded(
                flex: 2,
                child: Container(height: 30, color: Colors.red,),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              height: 100,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(height: 50, color: Colors.red,),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(height: 50, color: Colors.green,),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WrapWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        
      ),
    );
  }
}
