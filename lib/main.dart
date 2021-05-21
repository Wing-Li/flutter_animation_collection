import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/page/appears/appears_randomly_page.dart';
import 'package:flutter_animation_collection/utils/my_utils.dart';

import 'page/barrage/barrage_page.dart';
import 'page/ferriswheel/ferris_wheel_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    MyUtils.screenWidth = MyUtils.getScreenWidth(context);

    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: _appBar(),
      body: _body(),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 2,
      backgroundColor: Colors.white,
      title: Text("动画收藏", style: TextStyle(color: Colors.black, fontSize: 18)),
      centerTitle: true,
    );
  }

  _body() {
    return Column(
      children: [
        SizedBox(height: 16),
        GestureDetector(
          child: _item("弹幕"),
          onTap: () => MyUtils.startPageUpAnim(context, BarragePage()),
        ),
        GestureDetector(
          child: _item("随机渐变出现"),
          onTap: () => MyUtils.startPageGradient(context, AppearsRandomlyPage()),
        ),
        GestureDetector(
          child: _item("摩天轮转盘"),
          onTap: () => MyUtils.startPageGradient(context, FerrisWheelPage()),
        ),
      ],
    );
  }

  _item(String title) {
    return Container(
      height: 56,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: EdgeInsets.only(left: 20, right: 12, top: 14, bottom: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
          Icon(Icons.chevron_right, color: Colors.black26),
        ],
      ),
    );
  }
}
