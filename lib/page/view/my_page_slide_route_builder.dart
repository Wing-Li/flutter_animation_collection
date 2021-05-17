import 'package:flutter/material.dart';

// 从下往上划出
class MyPageSlideTransitionRouteBuilder<T> extends PageRouteBuilder<T> {
  // 跳转的页面
  final Widget widget;
  final int duration;

  MyPageSlideTransitionRouteBuilder(this.widget, {this.duration = 500})
      : super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return SlideTransition(
              child: child,
              position: Tween(begin: Offset(0.0, 1.0), end: Offset.zero).animate(
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
              ),
            );
          },
        );
}
