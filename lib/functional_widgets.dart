import 'package:flutter/material.dart';

class FunctionalWidgets extends StatelessWidget {
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
              _WillPopScopeWidget(),
              _ShareDataOperationWidget(),
              _ThemeTestWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _WillPopScopeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WillPopScopeState();
  }
}

class _WillPopScopeState extends State<_WillPopScopeWidget> {
  DateTime _lastPressBack;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text("1秒内连续按两次返回键退出", style: TextStyle(fontSize: 16),),
      ),
      onWillPop: () async {
        if (_lastPressBack != null && DateTime.now().difference(_lastPressBack) < Duration(milliseconds: 1000)) {
          return true;
        }
        _lastPressBack = DateTime.now();
        return false;
      },
    );
  }
}

class _ShareDataWidget extends InheritedWidget {
  _ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  final int data;

  static _ShareDataWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(_ShareDataWidget);
  }

  @override
  bool updateShouldNotify(_ShareDataWidget oldWidget) {
    return oldWidget.data != data;
  }
}

class _ShareDataDisplayWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShareDataDisplayState();
  }
}

class _ShareDataDisplayState extends State<_ShareDataDisplayWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Text(_ShareDataWidget.of(context).data.toString()),
    );
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    // 如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("didChangeDependencies");
  }
}

class _ShareDataOperationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShareDataOperationState();
  }
}

class _ShareDataOperationState extends State<_ShareDataOperationWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: _ShareDataWidget(
        data: _count,
        child: Column(
          children: <Widget>[
            _ShareDataDisplayWidget(),
            RaisedButton(
              child: Text("Increment", style: TextStyle(fontSize: 16),),
              onPressed: () => setState(() => ++_count),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeTestWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThemeTestState();
  }
}

class _ThemeTestState extends State<_ThemeTestWidget> {
  Color _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Theme(
            data: ThemeData(
              primarySwatch: _themeColor,
              iconTheme: IconThemeData(color: _themeColor,),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //第一行Icon使用主题中的iconTheme
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Icon(Icons.airport_shuttle),
                      Text("  颜色跟随主题")
                    ]
                ),
                //为第二行Icon自定义颜色（固定为黑色)
                Theme(
                  data: themeData.copyWith(
                    iconTheme: themeData.iconTheme.copyWith(color: Colors.black),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.favorite),
                        Icon(Icons.airport_shuttle),
                        Text("  颜色固定黑色")
                      ]
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            child: Text("Change Theme", style: TextStyle(fontSize: 16),),
            onPressed: () => setState(() =>
              _themeColor = _themeColor == Colors.teal ? Colors.red : Colors.teal
            ),
          ),
        ],
      )
    );
  }
}
