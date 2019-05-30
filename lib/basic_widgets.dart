import 'package:flutter/material.dart';

class BasicWidgetsPage extends StatefulWidget {

  @override
  State createState() {
    return _BasicWidgetsPageState();
  }
}

class _BasicWidgetsPageState extends State<BasicWidgetsPage> {
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
            _CountWidget(),
            _TextWidget(),
            _ButtonWidgets(),
            _ImageWidgets(),
            _CheckBoxWidgets(),
            _InputWidgets(),
          ],
        ),
      ),
    );
  }
}

class _CountWidget extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return _CountWidgetState();
  }
}

class _CountWidgetState extends State<_CountWidget> {
  int _count = 0;
  
  @override
  void initState() {
    super.initState();
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              color: Colors.white,
              onPressed: () => setState(() => {_count++}),
              child: Text(
                "$_count",
                style: TextStyle(color: Colors.blue, fontSize: 32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(_CountWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}

class _TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Text("textAlign: TextAlign.center, " * 3,
            textAlign: TextAlign.center,
          ),
          Text("maxLines: 1, overflow: TextOverflow.ellipsis, " * 4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text("textScaleFactor: 1.5, ",
            textScaleFactor: 1.5,
          ),
          Text("TextStyle",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                height: 1.2,
                fontFamily: "Courier",
                backgroundColor: Colors.yellow,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.dashed
            ),
          ),
          Text.rich(TextSpan(
              children: [
                TextSpan(text: "TextSpan"),
                TextSpan(text: "https://flutterchina.club",
                  style: TextStyle(
                      color: Colors.blue
                  ),
                ),
              ]
          )),
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
            textAlign: TextAlign.start,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("hello world"),
                Text("hello world",
                  style: TextStyle(
                    // 不继承默认样式
                      inherit: false,
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ButtonWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          RaisedButton(onPressed: () => {}, child: Text("Raised"),),
          OutlineButton(onPressed: () => {}, child: Text("Outline"),),
          IconButton(onPressed: () => {}, icon: Icon(Icons.add_a_photo),),
          FlatButton(
            onPressed: () => {},
            color: Colors.blue,
            highlightColor: Colors.red,
            colorBrightness: Brightness.dark,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Text("Flat"),
          ),
        ],
      ),
    );
  }
}

class _ImageWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Image.asset("images/icon.jpg", width: 200, height: 100, fit: BoxFit.contain, repeat: ImageRepeat.repeat,),
          Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4", width: 100,
            color: Colors.yellow,
            colorBlendMode: BlendMode.difference,
          ),
          Text("\uE914" + " \uE000" + " \uE90D",
            style: TextStyle(
                fontFamily: "MaterialIcons",
                fontSize: 24.0,
                color: Colors.green
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckBoxWidgets extends StatefulWidget {
  @override
  State createState() {
    return _CheckBoxWidgetsState();
  }
}

class _CheckBoxWidgetsState extends State<_CheckBoxWidgets> {
  bool _switchSelected = false;
  bool _checkBoxSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: <Widget>[
          Switch(
            value: _switchSelected,
            onChanged: (v) => { setState(() => { _switchSelected = v }) },
            activeColor: Colors.red,
          ),
          Checkbox(
            value: _checkBoxSelected,
            onChanged: (v) => { setState(() => { _checkBoxSelected = v }) },
            checkColor: Colors.green,
            activeColor: Colors.red,
          )
        ],
      ),
    );
  }
}

class _InputWidgets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InputWidgetsState();
  }
}

class _InputWidgetsState extends State<_InputWidgets> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => {
      print(_controller.text)
    });
    _controller.text="hello world!";
    _controller.selection=TextSelection(
        baseOffset: 2,
        extentOffset: _controller.text.length
    );

    _focusNode.addListener(() => {
      print(_focusNode.hasFocus.toString())
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              prefixIcon: Icon(Icons.person),
            ),
            controller: _controller,
            focusNode: _focusNode,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              prefixIcon: Icon(Icons.lock),
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}