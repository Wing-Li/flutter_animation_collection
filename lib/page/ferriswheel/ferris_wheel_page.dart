import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/page/base_state.dart';
import 'package:flutter_animation_collection/utils/my_utils.dart';

import 'ferris_wheel_widget.dart';

class FerrisWheelPage extends StatefulWidget {
  @override
  _FerrisWheelPageState createState() => _FerrisWheelPageState();
}

class _FerrisWheelPageState extends BaseState<FerrisWheelPage> {
  double _closeButtonOpacity = 0.0;

  List<String> list = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), _setCloseButtonOpacity);

    list = List.generate(30, (index) => "img$index");
  }

  _setCloseButtonOpacity() {
    setState(() {
      _closeButtonOpacity = 0.7;
    });
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
                child: _closeButton(),
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
          top: ferrisWidth / 2 - 80 / 2,
          left: 0,
          right: 0,
          child: Container(
            alignment: Alignment.topCenter,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(68),
              ),
              alignment: Alignment.center,
              child: Text(
                "Tap to\nchange\n5left",
                style: TextStyle(color: Colors.white, fontSize: 12),
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

  _closeButton() {
    return FractionallySizedBox(
      widthFactor: 0.6,
      child: AnimatedOpacity(
        opacity: _closeButtonOpacity,
        duration: Duration(milliseconds: 1500),
        child: RoundButton(
          "关闭",
          () => MyUtils.popPage(context),
          backgroundColor: Color(0xFF8C66EB),
          textColor: Colors.white,
        ),
      ),
    );
  }
}
