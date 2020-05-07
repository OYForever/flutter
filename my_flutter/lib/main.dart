import 'package:flutter/material.dart';

void main() => runApp(TabBarSample());

class TabBarSample extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 添加DefaultTabController关联TabBar及TabBarView
      home: DefaultTabController(
        length: items.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('TabBar选项卡示例'),
            bottom: TabBar(
              isScrollable: true, // 设置为可以滚动
              tabs: items.map((ItemView item) {
                return Tab(
                  text: item.title,
                  icon: Icon(item.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: items.map((ItemView item) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectedView(item: item),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// 视图项数据
class ItemView {
  const ItemView({this.title, this.icon});
  final String title;
  final IconData icon;
}

/// 选项卡类目
const List<ItemView> items = const <ItemView>[
  const ItemView(title: '自驾', icon: Icons.directions_car),
  const ItemView(title: '自行车', icon: Icons.directions_bike),
  const ItemView(title: '轮船', icon: Icons.directions_boat),
  const ItemView(title: '公交车', icon: Icons.directions_bus),
  const ItemView(title: '火车', icon: Icons.directions_railway),
  const ItemView(title: '步行', icon: Icons.directions_walk),
];

/// 被选中的视图
class SelectedView extends StatelessWidget {
  const SelectedView({Key key, this.item}) : super(key: key);

  // 视图数据
  final ItemView item;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.headline4;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // 垂直方向最小化处理
          crossAxisAlignment: CrossAxisAlignment.center, // 水平方向居中对齐
          children: <Widget>[
            Icon(item.icon, size: 128.0, color: textStyle.color),
            Text(item.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}
