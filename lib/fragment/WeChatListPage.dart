import 'package:flutter/material.dart';
import 'package:flutter_wechat/data/ConstantsValue.dart';
import 'package:flutter_wechat/activity/SearchView.dart';
import 'package:flutter_wechat/activity/PersonalChatView.dart';
import 'package:flutter_wechat/util/TextStyle.dart' as testStyle;

///微信聊天信息List
class WechatInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return WechatInfoPageState();
  }
}

class WechatInfoPageState extends State<WechatInfoPage> {
  ScrollController _scrollController;
  static const _nickName = [
    "原来足球是圆的",
    "原来乒乓球是圆的",
    "原来篮球是圆的",
    "原来排球是圆的",
    "原来网球是圆的",
    "原来手球是圆的",
    "原来台球是圆的",
    "原来保龄球是圆的",
    "原来高尔夫球是圆的",
    "原来桌球是圆的"
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(children: <Widget>[_buildTitleBar(), buildChatInfoList()]);
  }

  ///聊天消息列表
  Widget buildChatInfoList() {
    return Expanded(
      //用于给出ListView的高度
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: _getChatItem,
        itemCount: 20,
      ),
    );
  }

  ///绘制聊天列表Item
  Widget _getChatItem(BuildContext context, int index) {
    if (index == 0) {
      return buildSearchView();
    }
    return GestureDetector(
      onTap: () => _clickChatItem,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.white,
            width: 60,
            height: 60,
            padding: EdgeInsets.only(left: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                getAvatarLocalPath(index),
                width: 52,
                height: 52,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 60,
              padding: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromRGBO(0xCF, 0xCF, 0xCF, 1)))),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 2),
                        child: Text(_nickName[index % 10],
                            style: TextStyle(fontSize: 14)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: <Widget>[
                            Offstage(
                              offstage: index % 3 == 1 ? false : true,
                              child:
                                  Text("[n条]", style: testStyle.textStyle1()),
                            ),
                            Padding(padding: EdgeInsets.only(right: 2)),
                            Text("最后一条消息", style: testStyle.textStyle1()),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text("time", style: testStyle.textStyle1())),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getAvatarLocalPath(int index) {
    var i = index % 3;
    var path;
    switch (i) {
      case 0:
        path = "images/avatar_0.png";
        break;
      case 1:
        path = "images/avatar_1.png";
        break;
      case 2:
        path = "images/avatar_2.png";
        break;
      default:
        path = "images/avatar_default.png";
        break;
    }
    return path;
  }

  ///绘制SearchView
  Widget buildSearchView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: GestureDetector(
        //用于添加View的点击事件GestureDetector
        onTap: () => _clickSearch,
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.search,
                color: Colors.grey,
                size: 16,
              ),

              ///设置间隔
              Padding(padding: const EdgeInsets.fromLTRB(3, 0, 3, 0)),
              Text(
                "搜索",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///顶部TitleBar
  Padding _buildTitleBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Stack(
        ///类似RelativeLayout,可以通过Center,Position等控件来控制位置
        children: <Widget>[
          Center(
            child: Text(
              ConstantsValue.BOTTOM_NAV_CHAT_LIST,
              style: testStyle.titleBarStyle(),
            ),
          ),
          Positioned(
            right: 20,
            top: 0,
            child: GestureDetector(
              onTap: _showPopupWindow(),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showPopupWindow() {}

  void _clickSearch() => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchView()));

  void _clickChatItem() {
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, anim, secondAnim) {
              return PersonalChatView();
            },
            transitionDuration: Duration(milliseconds: 200),
            // 切换动画的切换效果，系统自带的常用 Transition
            // ScaleTransition: 缩放  SlideTransition: 滑动
            // RotationTransition: 旋转  FadeTransition: 透明度
            transitionsBuilder: (context, anim, secondAnim, child) =>
                SlideTransition(
                  position: Tween(begin: Offset(1, 0), end: Offset(0, 0))
                      .animate(anim),
                  // 这个值必须记得要传，否则会不显示界面
                  child: child,
                )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
