import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/page/view/my_page_fade_route_builder.dart';
import 'package:flutter_animation_collection/page/view/my_page_slide_route_builder.dart';

class MyUtils {
  static double screenWidth = 375.0;

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  ///获取本地资源图片
  static String getImage(String imageName, {String format: 'png'}) {
    return "assets/images/$imageName.$format";
  }

  /// 跳转页面
  static Future<Map> startPage(BuildContext context, Widget page) async {
    return await Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  /// 跳转页面，带渐变动画
  static Future<Map> startPageGradient(BuildContext context, Widget page, {int duration = 500}) async {
    return await Navigator.push(context, MyPageFadeTransitionRouteBuilder(page, duration: duration));
  }

  /// 从下往上划出
  static Future<Map> startPageUpAnim(BuildContext context, Widget page, {int duration = 500}) async {
    return await Navigator.push(context, MyPageSlideTransitionRouteBuilder(page, duration: duration));
  }

  /// 关闭页面
  static void popPage(BuildContext context, {Map map}) {
    if (map != null) {
      Navigator.of(context).pop(map);
    } else {
      Navigator.of(context).pop();
    }
  }
}
