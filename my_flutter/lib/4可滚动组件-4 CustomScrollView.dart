//4可滚动组件-4 CustomScrollView
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  double extraPicHeight = 0;
  double prevDy;
  double scrollOffsetY = 0;

  AnimationController animationController;
  Animation<double> anim;

  @override
  void initState() {
    super.initState();
    prevDy = 0;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    anim = Tween(begin: 0.0, end: 0.0).animate(animationController);
  }

  void updatePicHeight(changed) {
    if (prevDy == 0) {
      prevDy = changed;
    }
    extraPicHeight += changed - prevDy;

    setState(() {
      prevDy = changed;
      extraPicHeight = extraPicHeight;
    });
  }

  void runAnimate() {
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          setState(() {
            extraPicHeight = anim.value;
          });
        });
      prevDy = 0;
    });
  }

  bool _onNotification(Notification notification) {
    if (notification is! ScrollNotification) {
      return false;
    }

    ScrollNotification scrollNotification = notification as ScrollNotification;
    scrollOffsetY = scrollNotification.metrics.pixels;

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Listener(
        onPointerMove: (moveEvent) {
          updatePicHeight(moveEvent.position.dy);
        },
        onPointerUp: (_) {
          runAnimate();
          if (scrollOffsetY == 0.0) {
            animationController.forward(from: 0);
          }
        },
        child: NotificationListener(
          onNotification: _onNotification,
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            // physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              //AppBar，包含一个导航栏
              SliverAppBar(
                pinned: true,
                expandedHeight: 250.0 + extraPicHeight,
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text('Demo'),
                  background: Image.asset(
                    "./images/avatar.png",
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.parallax,
                  stretchModes: [StretchMode.zoomBackground],
                ),
              ),

              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                sliver: SliverGrid(
                  //Grid
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //Grid按两列显示
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 4.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      //创建子widget
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.cyan[100 * (index % 9)],
                        child: Text('grid item $index'),
                      );
                    },
                    childCount: 20,
                  ),
                ),
              ),
              //List
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    //创建列表项
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.lightBlue[100 * (index % 9)],
                      child: Text('list item $index'),
                    );
                  },
                  childCount: 50, //50个列表项
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
