import 'package:flutter/material.dart';

class ContainerWidgetsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    var title = args["title"];
    var color = args["color"];
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(Colors.white70),
            ),
          ),
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _Paddings(),
            _ConstrainBox(),
            _DecoratedBox(),
            _Transform(),
          ],
        ),
      ),
    );
  }
}

class _Paddings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text("EdgeInsets.only(left: 8)"),
              ),
              color: Colors.red,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text("EdgeInsets.symmetric(vertical: 8)"),
              ),
              color: Colors.red,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text("EdgeInsets.fromLTRB(20, 0, 20, 20)"),
              ),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class _ConstrainBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var redBox = Container(
      height: 5,
      child: DecoratedBox(decoration: BoxDecoration(color: Colors.red)),
    );
    return Card(
      child: Column(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50.0,
            ),
            child: redBox,
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: redBox,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0),
              child: redBox,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 90.0, minHeight: 50.0),
            child: UnconstrainedBox( // 去除父 BoxConstraints 的限制
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: 60.0, minHeight: 20.0),
                child: redBox,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DecoratedBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.red, Colors.green]),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(10, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(padding: EdgeInsets.symmetric(horizontal: 80, vertical: 18),
        child: Text("Login", style: TextStyle(color: Colors.white),),
      ),
    );
  }
}

class _Transform extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            child: Transform(transform: Matrix4.skewY(0.3),
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.all(8.0),
                color: Colors.deepOrange,
                child: Text("Apartment for sale!"),
              ),
            ),
          ),
          Container(
            color: Colors.green,
            child: Transform.translate(offset: Offset(20, -5),
              child: Text("Transform.translate"),
            ),
          ),
          Container(
            color: Colors.green,
            width: 200,
            height: 50,
            alignment: Alignment.center,
            child: Transform.rotate(angle: 3.14159 / 8,
              child: Text("Transform.rotate"),
            ),
          ),
          Container(
            color: Colors.green,
            child: Transform.scale(scale: 0.7,
              child: Text("Transform.scale"),
            ),
          ),
          Container(
            color: Colors.green,
            child: RotatedBox(quarterTurns: 1,
              child: Text("RotatedBox"),
            ),
          ),
        ],
      ),
    );
  }
}