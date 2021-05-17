import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> with WidgetsBindingObserver {

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
