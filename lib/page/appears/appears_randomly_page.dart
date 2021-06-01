import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/page/base_state.dart';
import 'package:flutter_animation_collection/utils/my_utils.dart';
import 'package:flutter_appears_randomly/appears_randomly_widget.dart';

/// 集成 flutter_appears_randomly 库
class AppearsRandomlyPage extends StatefulWidget {
  AppearsRandomlyPage({
    Key key,
  }) : super(key: key);

  @override
  _AppearsRandomlyPageState createState() => _AppearsRandomlyPageState();
}

class _AppearsRandomlyPageState extends BaseState<AppearsRandomlyPage> {
  double screenWidth = 375;

  List<String> list = [];

  @override
  void initState() {
    initCloseButton(true, 500);

    super.initState();

    list = List.generate(30, (index) => "img$index");
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFF2E2E4A),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(MyUtils.getImage("bg_anim", format: "webp")), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Spacer(flex: 1),
            Container(
              width: screenWidth,
              height: screenWidth,
              child: _appearsRandomlyGradientLayout(),
            ),
            Expanded(
              flex: 4,
              child: Center(child: MyCloseButton()),
            ),
          ],
        ),
      ),
    );
  }

  _appearsRandomlyGradientLayout() {
    double iconWidth = screenWidth * 110 / 375;
    return Stack(
      children: [
        Image.asset(MyUtils.getImage("bg_header_ripple_anim", format: "webp"), width: double.infinity, height: double.infinity),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16), // 为了防止贴边不美观。（可以去掉）
          child: AppearsRandomlyWidget(
            width: screenWidth,
            // 整体的宽高。用于计算 item 出现的范围
            height: screenWidth,

            itemWidth: 56,
            // 每个 item 的宽高。用于计算 item 的出现
            itemHeight: 56,
            itemSizeRange: 16,
            // 从小变大时，最大/最小的缩放范围。（会生成随机值，此处为最大值）

            centerRestrictedArea: Size(iconWidth, iconWidth),
            // 中心布局的范围
            centerChild: Container(
              // 中心布局。（可为空）
              width: iconWidth,
              height: iconWidth,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: ClipOval(
                child: Image.asset(MyUtils.getImage("header", format: "webp"), width: iconWidth, height: iconWidth, fit: BoxFit.cover),
              ),
            ),

            itemCount: list.length,
            // 总数
            itemBuilder: (context, index) {
              // item 布局
              var imgRes = list[index];
              return GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    border: Border.all(color: Colors.white, width: 0.5),
                  ),
                  child: ClipOval(child: Image.asset(MyUtils.getImage(imgRes), width: 52, height: 52, fit: BoxFit.cover)),
                ),
                onTap: () {
                  // TODO: 点击
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
