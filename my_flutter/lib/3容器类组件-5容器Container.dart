//3容器类组件-5容器Container
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //在此处添加子控件
          Container(
            margin: EdgeInsets.only(top: 50, left: 120),
            constraints: BoxConstraints.tightFor(width: 200, height: 150),
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Colors.red, Colors.orange],
                center: Alignment.topLeft,
                radius: 0.98,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            transform: Matrix4.rotationZ(0.2),
            alignment: Alignment.center,
            child: Text(
              "5.20",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          Container(height: 50,),
          Container(
            margin: EdgeInsets.all(20.0), //容器外补白
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
          Container(
            padding: EdgeInsets.all(20.0), //容器内补白
            color: Colors.orange,
            child: Text("Hello world!"),
          ),
        ],
      ),
    );
  }
}
