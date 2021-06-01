import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_collection/model/user_model.dart';
import 'package:flutter_animation_collection/page/base_state.dart';
import 'package:flutter_animation_collection/utils/my_utils.dart';

import 'flutter_barrage.dart';

/// 使用了 flutter_barrage 库，但是这个库有点问题，重写了一下。
/// 可将其复制到自己项目。 flutter_animation_collection/lib/page/barrage/barrage_page.dart
class BarragePage extends StatefulWidget {
  @override
  _BarragePageState createState() => _BarragePageState();
}

class _BarragePageState extends BaseState<BarragePage> {
  final mBarrageWallController = BarrageWallController();
  Timer _barrageTimer;

  @override
  void initState() {
    initCloseButton(true, 2000);

    super.initState();

    Future.delayed(Duration.zero, _fetchBarrageData);
  }

  Future<Null> _fetchBarrageData({bool isShowLoading = false}) async {
    if (_barrageTimer != null) _barrageTimer.cancel();

    List<UserModel> userList = List.generate(30, (index) {
      return UserModel(
        name: "用户$index",
        iconUrl: "img$index",
        bio: "该用户很懒没有简介",
      );
    });

    _startBarrage(userList);
  }

  _startBarrage(List<UserModel> userList) {
    Future.delayed(Duration.zero, () {
      _barrageTimer?.cancel();
      _barrageTimer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
        if (userList == null || userList.length <= 0) {
          _barrageTimer.cancel();
          return;
        }

        int _random = Random().nextInt(userList.length);
        var user = userList[_random];
        var child = _barrageItem(user);

        mBarrageWallController.send([Bullet(child: child)]);
      });
    });
  }

  _barrageItem(UserModel user) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        padding: EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(26)),
          border: Border.all(color: Color(0xFF6F7177), width: 0.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(MyUtils.getImage(user.iconUrl), width: 32, height: 32, fit: BoxFit.cover),
            ),
            SizedBox(width: 8),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.name}",
                    style: TextStyle(color: Color(0xFFDCDCDD), fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    user.bio,
                    style: TextStyle(color: Color(0xFFDCDCDD), fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
      onTap: () {
        // TODO: 点击
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2E2E4A),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(MyUtils.getImage("bg_anim", format: "webp")), fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Spacer(flex: 1),
            Expanded(flex: 6, child: _barrageLayout()),
            Expanded(
              flex: 4,
              child: Center(child: MyCloseButton()),
            ),
          ],
        ),
      ),
    );
  }

  _barrageLayout() {
    return Container(
      child: BarrageWall(
        debug: false,
        maxBulletHeight: 80,
        // safeBottomHeight: 60,
        speed: 6,
        speedCorrectionInMilliseconds: 3000,
        bullets: [],
        child: new Container(),
        controller: mBarrageWallController,
      ),
    );
  }
}
