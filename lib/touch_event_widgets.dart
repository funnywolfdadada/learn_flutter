import 'package:flutter/material.dart';

class TouchEventWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    var title = args["title"];
    var color = args["color"];
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(title: Text(title),),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _TouchListenerWidget(),
              _TouchBehaviorWidgets(),
              _GestureTestWidget(),
              _DragWidget(),

            ],
          ),
        ),
      ),
    );
  }
}

class _TouchListenerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TouchListenerState();
  }
}

class _TouchListenerState extends State<_TouchListenerWidget> {

  PointerEvent _event;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Listener(
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue,
          height: 150,
          child: Text(
            _event?.toString() ?? "",
            style: TextStyle(color: Colors.white),
          ),
        ),
        onPointerDown: (PointerDownEvent event) => setState(() => _event = event),
        onPointerMove: (PointerMoveEvent event) => setState(() => _event = event),
        onPointerUp: (PointerUpEvent event) => setState(() => _event = event),
      ),
    );
  }
}

class _TouchBehaviorWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(200, 100)),
              child: DecoratedBox(decoration: BoxDecoration(color: Colors.blue)),
            ),
            onPointerDown: (_) => print("down 0"),
          ),
          Listener(
            child: ConstrainedBox(
              constraints: BoxConstraints.tight(Size(100, 100)),
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
                child: Center(child: Text("左上角200*100范围内非文本区域点击")),
              ),
            ),
            onPointerDown: (_) => print("down 1"),
            behavior: HitTestBehavior.translucent,
          ),
        ],
      ),
    );
  }
}

class _GestureTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GestureTextState();
  }
}

class _GestureTextState extends State<_GestureTestWidget> {
  String _operation = "Nothing";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        child: Container(
          height: 100,
          color: Colors.blue,
          child: Center(
            child: Text(_operation, style: TextStyle(color: Colors.white),),
          ),
        ),
        onTap: () => setState(() => _operation = "tap"),
        onDoubleTap: () => setState(() => _operation = "double tap"),
        onLongPress: () => setState(() => _operation = "long press"),
      ),
    );
  }
}

class _DragWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DragState();
  }
}

class _DragState extends State<_DragWidget> with SingleTickerProviderStateMixin {
  double _top = 0.0;
  double _left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amberAccent,
      height: 100,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: _top,
              left: _left,
              child: CircleAvatar(
                child: Icon(Icons.add_location),
              ),
            ),
          ],
        ),
        onPanDown: (e) => print(e.globalPosition.toString()),
        onPanUpdate: (e) => setState(() {
          _top = e.globalPosition.dy;
          _left = e.globalPosition.dx;
        }),
      )
    );
  }
}
