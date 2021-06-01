import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/utils/my_utils.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {
  double _closeButtonOpacity = 0.0;
  int _startMilliseconds = 2000;

  @override
  void initState() {
    super.initState();

    if (_closeButtonOpacity != -1) Future.delayed(Duration(milliseconds: _startMilliseconds), _setCloseButtonOpacity);
  }

  initCloseButton(bool isOpen, int _startMilliseconds) {
    _closeButtonOpacity = isOpen ? 0.0 : -1;
    _startMilliseconds = _startMilliseconds;
  }

  _setCloseButtonOpacity() {
    setState(() {
      _closeButtonOpacity = 0.7;
    });
  }

  Widget MyCloseButton() {
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

  // =================================== ↓ 常用自定义组件 ↓ ==========================================

  Widget RoundButton(String text, Function onTap, {Color backgroundColor, Color textColor, bool isFullWidth = true}) {
    return ButtonTheme(
      height: 52,
      minWidth: isFullWidth ? double.infinity : 0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        color: backgroundColor == null ? Colors.deepOrangeAccent : backgroundColor,
        // elevation: 1,
        highlightElevation: 0,
        disabledElevation: 0,
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: textColor == null ? Colors.white : textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

// =================================== ↑ 常用自定义组件 ↑ ==========================================
}
