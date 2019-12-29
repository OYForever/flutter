//3容器类组件-7剪裁（Clip）
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ClipTestRoute(),
    );
  }
}

class ClipTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //头像
    Widget avatar = Image.asset(
      "images/avatar.png",
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    );
    return Center(
      child: Column(
        children: <Widget>[
          avatar, //不裁剪
          Container(height: 30), //间距
          ClipOval(child: avatar), //裁剪为圆形
          Container(height: 30), //间距
          ClipRRect(
            child: avatar,
            borderRadius: BorderRadius.circular(10),
          ), // 裁剪为圆角矩形
          Container(height: 30), //间距
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                widthFactor: 0.5,
                child: avatar,
              ),
              Text(
                "你好世界",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipRect(
                child: Align(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: avatar,
                ),
              ),
              Text(
                "你好世界",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.red,
            ),
            child: ClipRect(
              clipper: MyClipper(),
              child: avatar,
            ),
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(10, 15, 40, 30);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    //false 不会触发重新裁剪
    //如果剪裁区域会发生变化（比如在对剪裁区域执行一个动画）
    //，那么变化后应该返回true来重新执行剪裁。
    return true; 
  }
}