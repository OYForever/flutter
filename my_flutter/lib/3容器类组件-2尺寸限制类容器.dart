//3容器类组件-2尺寸限制类容器
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
  Widget redBox = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.red,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          UnconstrainedBox(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation(Colors.white70),
              ),
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //在此处添加子控件
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: double.infinity,
              minHeight: 50,
            ),
            child: Container(
              height: 5.0,
              child: redBox,
            ),
          ),
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: redBox,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
              child: redBox,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 60.0), //父
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 90.0, minHeight: 20.0), //子
              child: redBox,
            ),
          ),
          //通过上面示例，我们发现有多重限制时，对于minWidth和minHeight来说，是取父子中相应数值较大的(max则取小)。实际上，只有这样才能保证父限制与子限制不冲突。
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: 60.0, minHeight: 100.0), //父
            child: UnconstrainedBox(
              //“去除”父级限制
              alignment: FractionalOffset(1, 1),
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minWidth: 10.0, minHeight: 20.0), //子
                child: redBox,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
