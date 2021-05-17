import 'package:flutter/material.dart';

// 渐变出现
class MyPageFadeTransitionRouteBuilder<T> extends PageRouteBuilder<T> {
  // 跳转的页面
  final Widget widget;
  final int duration;

  MyPageFadeTransitionRouteBuilder(this.widget, {this.duration = 500})
      : super(
          transitionDuration: Duration(milliseconds: duration),
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
            return FadeTransition(
              child: child,
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
              ),
            );
          },
        );
}
