import 'dart:math';

import 'package:flutter/material.dart';

class FerrisWheelWidget extends StatefulWidget {
  final double width;
  final double height;

  final Size itemSize;

  final List<Widget> children;
  final Widget centerWidget; // 中心控件在 children 下方

  const FerrisWheelWidget({
    Key key,
    this.children,
    this.width,
    this.height,
    this.centerWidget,
    this.itemSize,
  })  : assert(children != null),
        assert(itemSize != null),
        super(key: key);

  @override
  _FerrisWheelWidgetState createState() => _FerrisWheelWidgetState();
}

class _FerrisWheelWidgetState extends State<FerrisWheelWidget> with SingleTickerProviderStateMixin {
  double width;
  double height;

  AnimationController _controller;
  double rad = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 15 * 1000), vsync: this)
      ..addListener(
        () => setState(() => rad = 1 - _controller.value * pi * 2),
      );
    _controller.repeat();
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose(); //销毁变量,释放资源
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    width = widget.width != null ? widget.width : size.width;
    height = widget.height != null ? widget.height : size.height;

    return Stack(
      children: [
        widget.centerWidget == null
            ? SizedBox()
            : Transform.rotate(
                angle: rad,
                child: Container(
                  width: width,
                  height: height,
                  child: widget.centerWidget,
                ),
              ),
        Container(
          width: width,
          height: height,
          child: Flow(
            delegate: _CircleFlowDelegate(rad, widget.itemSize),
            children: widget.children,
          ),
        ),
      ],
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  final double rad;
  final Size size;

  _CircleFlowDelegate(this.rad, this.size);

  @override
  void paintChildren(FlowPaintingContext context) {
    // 半径
    double radius = context.size.shortestSide / 2;

    var count = context.childCount;
    var perRad = 2 * pi / count;
    for (int i = 0; i < count; i++) {
      // item 的宽高
      var cSizeX = context.getChildSize(i).width / 2;
      var cSizeY = context.getChildSize(i).height / 2;
      // 每个 item 的位置
      var offsetX = (radius - cSizeX) * cos(i * perRad + rad) + radius;
      var offsetY = (radius - cSizeY) * sin(i * perRad + rad) + radius;
      context.paintChild(i, transform: Matrix4.translationValues(offsetX - cSizeX, offsetY - cSizeY, 0.0));
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return super.getSize(constraints);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: size.width,
      minHeight: size.height,
      maxWidth: size.width,
      maxHeight: size.height,
    );
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return true;
  }
}
