import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/page/base_state.dart';
import 'package:flutter_animation_collection/utils/my_utils.dart';

import 'ferris_wheel_widget.dart';

class FerrisWheelPage extends StatefulWidget {
  @override
  _FerrisWheelPageState createState() => _FerrisWheelPageState();
}

class _FerrisWheelPageState extends BaseState<FerrisWheelPage> {
  List<String> list = [];

  @override
  void initState() {
    initCloseButton(true, 500);

    super.initState();

    list = List.generate(30, (index) => "img$index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC58FFF),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(MyUtils.getImage("bg_anim", format: "webp")), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Spacer(flex: 1),
            _ferrisWheelLayout(),
            Expanded(
              flex: 4,
              child: Center(
                child: MyCloseButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ferrisWheelLayout() {
    double ferrisWidth = MyUtils.screenWidth * 0.9;
    return Stack(
      children: [
        SizedBox(width: ferrisWidth, height: ferrisWidth * 1.5),
        Positioned(
          top: ferrisWidth / 2,
          left: 0,
          right: 0,
          child: Container(
            child: Center(child: Image.asset(MyUtils.getImage("img_mtl_bracket"))),
          ),
        ),
        FerrisWheelWidget(
          width: ferrisWidth,
          height: ferrisWidth,
          itemSize: Size(52, 52),
          children: _buildFlowChildren(),
          centerWidget: Padding(
            padding: EdgeInsets.all(50),
            child: Image.asset(MyUtils.getImage("img_mtl")),
          ),
        ),
        Positioned(
          top: (ferrisWidth - 70) / 2,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.topCenter,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.circular(68),
                border: Border.all(color: Color(0xFF252525), width: 4),
              ),
              alignment: Alignment.center,
              child: Text(
                "❤\nLove",
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //生成Flow的数据
  List<Widget> _buildFlowChildren() {
    return List.generate(
      8,
      (index) => SizedBox(
        width: 52,
        height: 52,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: ClipOval(
            child: Image.asset(MyUtils.getImage(list[index]), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
