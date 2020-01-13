import 'package:flutter/material.dart';
import 'package:flutter_wechat/data/ConstantsValue.dart';
import 'package:flutter_wechat/activity/SearchView.dart';
import 'package:flutter_wechat/activity/PersonalChatView.dart';
import 'package:flutter_wechat/util/TextStyle.dart' as testStyle;

///微信聊天信息List， 上拉加载更多，一次最多加载10个
class WechatInfoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return WechatInfoPageState();
  }
}

class WechatInfoPageState extends State<WechatInfoPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = ScrollController();
  int _itemCount = 10;
  /// 加载更多状态，提示上拉加载更多
  final _SCROLL_STATE_LOAD_MORE = 0;
  /// 加载中
  final _SCROLL_STATE_LOADING = 1;
  /// 没有更多数据
  final _SCROLL_STATE_NO_MORE_DATE = 2;
  var _currentState;

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
  void initState() {
    super.initState();

    _currentState = _SCROLL_STATE_LOAD_MORE;

    /// Register a closure to be called when ###the object changes###.
    /// 需要在initState()中进行监听
    /// ScrollController中包含一个ScrollPosition，里面包含的信息更加丰富，
    /// 如果一个ScrollController监听多个滑动widget，可以用ScrollPosition加以区分
    _scrollController.addListener((){
      /// _scrollController.offset == _scrollController.position.pixels滑动的距离
      /// maxScrollExtent：最大可滑动距离，    minScrollExtent：最小可滑动距离，0
      /// jumpTo():控制滑动组件的滑动距离，无动画 ,   animateTo():控制滑动组件的滑动距离，有动画
      if (_scrollController.offset
          == _scrollController.position.maxScrollExtent) { /// 滑动距离等于最大滑动距离，说明滑到底部
          _loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(children: <Widget>[_buildTitleBar(), buildChatInfoList()]);
  }

  ///聊天消息列表
  Widget buildChatInfoList() {
    return Expanded(
      /// Scrollbar的child可以是ListView,GridView也可以是NotificationListener
      /// 当是NotificationListener不显示滚动条，但可以通过NotificationListener获得滚动的progress
      /// double progress = notification.metrics.pixels / notification.metrics.maxScrollExtent;
      child: Scrollbar(
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: _getChatItem,
///        itemExtent: 60, /// 如果每个Item的height确定且一致则使用这个配置，更高效
          /// 一个Search，一个上拉加载更多/加载中/没有更多
          itemCount: _itemCount + 2,
        ),
      ),
    );
  }

  ///绘制聊天列表Item
  Widget _getChatItem(BuildContext context, int index) {
    if (index == 0) {
      return buildSearchView();
    } else if (index == _itemCount + 1) {
      return buildTailItem();
    }
    return buildChatItem(context, index);
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

  /// 加载更多
  void _loadMore() {
      if (_itemCount < 30) {
        Future.delayed(Duration(seconds: 2), (){
          _itemCount += 10;
          setState(() {
            _currentState = _SCROLL_STATE_LOAD_MORE;
          });
        });
        setState(() {
          _currentState = _SCROLL_STATE_LOADING;
        });
      } else {
        setState(() {
          _currentState = _SCROLL_STATE_NO_MORE_DATE;
        });
      }
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

  Widget buildTailItem() {
    if (_currentState == _SCROLL_STATE_LOAD_MORE) {
      return Container(height: 40, child: Center(child: Text("上拉加载更多")));
    } else if (_currentState == _SCROLL_STATE_LOADING) {
      return Container(height: 40, child: Center(child: SizedBox(width: 30, height: 30,
          child: CircularProgressIndicator(backgroundColor: Colors.grey, valueColor: AlwaysStoppedAnimation(Colors.blue),))));
    } else {
      return Container(height: 40, child: Center(child: Text("没有更多数据")));
    }
  }

  Widget buildChatItem(context, index) {
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
    _scrollController.dispose();
  }

}
