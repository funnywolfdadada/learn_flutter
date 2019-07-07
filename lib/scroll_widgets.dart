import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class ScrollWidgetsPage extends StatelessWidget {
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
              _decorate(_SingleScrollWidget()),
              _decorate(_SimpleListWidget()),
              _decorate(_SeparatedListWidget()),
              _decorate(_InfiniteListView()),
              _decorate(_GridViewWithFixCount()),
              _decorate(_GridViewWithFixWidth()),
              _decorate(_InfiniteGridView()),
              _decorate(_CustomScrollView(), height: 500),
              _decorate(_ScrollControllerTest(), height: 500),
              _decorate(_ScrollNotificationTest(), height: 500),

            ],
          ),
        ),
      ),
    );
  }
}

Widget _decorate(Widget raw, {double height = 200, Color background = Colors.white}) {
  return Container(
    height: height,
    margin: EdgeInsets.all(10),
    color: background,
    child: raw,
  );
}

class _SingleScrollWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scrollbar(
      child: SingleChildScrollView(
        reverse: true,
        child: Center(
          child: Column(
            children: str.split("").map((c) => Text(c, textScaleFactor: 2.0,)).toList(),
          ),
        ),
      ),
    );
  }
}

class _SimpleListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemExtent: 50,
      itemBuilder: (context, index) => Text("$index", textScaleFactor: 2.0),
    );
  }
}

class _SeparatedListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> dividers = [
      Divider(color: Colors.blue,),
      Divider(color: Colors.green,)
    ];
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        child: Text("$index", textScaleFactor: 2.0),
      ),
      separatorBuilder: (context, index) => dividers[index % 2],
    );
  }
}

class _InfiniteListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteListViewState();
  }
}

class _InfiniteListViewState extends State<_InfiniteListView> {
  static const loadingTag = "##loading##";
  static const MAX_LENGTH = 100;

  var _words = [loadingTag];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _words.length,
      itemBuilder: (context, index) {
        if (_words[index] == loadingTag) {
          if (_words.length - 1 < MAX_LENGTH) {
            _loadData();
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2,),
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text("没有更多了", style: TextStyle(color: Colors.grey)),
            );
          }
        }
        return ListTile(title: Text(_words[index]),);
      },
      separatorBuilder: (context, index) => Divider(color: Colors.blue,),
    );
  }

  void _loadData() {
    Future.delayed(Duration(seconds: 2)).then( (e) {
      _words.insertAll(_words.length - 1, generateWordPairs().take(20).map((e) => e.asPascalCase).toList());
      setState(() {});
    });
  }
}

class _GridViewWithFixCount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class _GridViewWithFixWidth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 100,
      childAspectRatio: 2,
      children: <Widget>[
        Icon(Icons.ac_unit),
        Icon(Icons.airport_shuttle),
        Icon(Icons.all_inclusive),
        Icon(Icons.beach_access),
        Icon(Icons.cake),
        Icon(Icons.free_breakfast),
      ],
    );
  }
}

class _InfiniteGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfiniteGridViewState();
  }
}

class _InfiniteGridViewState extends State<_InfiniteGridView> {
  var _icons = List<IconData>();
@override
  void initState() {
    super.initState();
    _loadIcon();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: _icons.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 100, childAspectRatio: 2),
      itemBuilder: (context, index) {
        if (index == _icons.length - 1 && _icons.length < 200) {
          _loadIcon();
        }
        return Icon(_icons[index]);
      },
    );
  }

  void _loadIcon() {
    Future.delayed(Duration(seconds: 1)).then((e) {
      setState(() {
        _icons.addAll([
          Icons.ac_unit,
          Icons.airport_shuttle,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast
        ]);
      });
    });
  }
}

class _CustomScrollView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("CustomScrollView"),
              background: Image.asset("./images/background.jpg", fit: BoxFit.cover,),
            ),
          ),

          SliverPadding(padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Container(
                  alignment: Alignment.center,
                  color: Colors.cyan[100 * (index % 9)],
                  child: new Text('grid item $index'),
                ),
                childCount: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
            ),
          ),

          SliverFixedExtentList(
            itemExtent: 50,
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              ),
              childCount: 50,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScrollControllerTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollControllerTestState();
  }
}

class _ScrollControllerTestState extends State<_ScrollControllerTest> {
  ScrollController _scrollController = ScrollController(keepScrollOffset: true);
  bool _showToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset < 1000 && _showToTopButton) {
        setState(() { _showToTopButton = false; });
      } else if (_scrollController.offset >= 1000 && !_showToTopButton) {
        setState(() { _showToTopButton = true; });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: ListView.builder(
          itemCount: 100,
          itemExtent: 50,
          controller: _scrollController,
          itemBuilder: (context, index) => ListTile(title: Text("$index"),),
        ),
      ),
      floatingActionButton: !_showToTopButton ? null : FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _scrollController.animateTo(0, duration: Duration(milliseconds: 200), curve: Curves.ease);
        },
      ),
    );
  }
}

class _ScrollNotificationTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScrollNotificationTestState();
  }
}

class _ScrollNotificationTestState extends State<_ScrollNotificationTest> {
  String _process = "0%";

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        double process = notification.metrics.pixels / notification.metrics.maxScrollExtent;
        setState(() {
          _process = "${(process * 100).toInt()}%";
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ListView.builder(
            itemCount: 100,
            itemExtent: 50,
            itemBuilder: (context, index) => ListTile(title: Text("$index"),),
          ),
          CircleAvatar(
            radius: 30,
            child: Text(_process),
            backgroundColor: Colors.black54,
          ),
        ],
      ),
    );
  }
}
