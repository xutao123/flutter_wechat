import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wechat/redux/AppState.dart';
import 'data/ConstantsValue.dart';
import 'package:flutter_wechat/fragment/WeChatListPage.dart';
import 'package:flutter_wechat/fragment/ChatContactPage.dart';
import 'package:flutter_wechat/fragment/DiscoveryPage.dart';
import 'package:flutter_wechat/fragment/MePage.dart';

///首页导航控件
class NavWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NavWidgetState();
  }
}

class NavWidgetState extends State<NavWidget> {
  int _curPageIndex = 0;
  static PageController mPageController = PageController();
  List<Widget> _page = <Widget>[
    WechatInfoPage(),
    ChatContactPage(),
    DiscoveryPage(),
    MePage(),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    mPageController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0xE8, 0xE8, 0xE8, 0.8)),
      child: Column(
        children: <Widget>[
          _buildMainFragment(),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  ///绘制底部的导航栏
  Widget _buildBottomNavigation() {
    return StoreConnector<AppState,Color>(
        converter: (store) => store.state.themeColor,
      builder: (context, themeColor) => BottomNavigationBar(
        selectedItemColor: themeColor,
        selectedFontSize: 12,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 12,
        currentIndex: _curPageIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text(ConstantsValue.BOTTOM_NAV_CHAT_LIST)),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text(ConstantsValue.BOTTOM_NAV_CHAT_CONTACT)),
          BottomNavigationBarItem(
              icon: Icon(Icons.find_in_page),
              title: Text(ConstantsValue.BOTTOM_NAV_DISCOVER)),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text(ConstantsValue.BOTTOM_NAV_ME))
        ],

        //点击事件
        onTap: (index) {
          setState(() {
            _curPageIndex = index;
          });
          mPageController.jumpToPage(_curPageIndex);
        },
      )
    );
  }

  ///Fragment View
  Expanded _buildMainFragment() {
    return Expanded(
        //使得ViewPage填充整个页面除BottomNavigationBar之外，剩余的空间
        child: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: mPageController,
          itemCount: 4,
          itemBuilder: ((context, index) {
            return _page[index];
          }),
            onPageChanged: (index) => setState((){
                _curPageIndex = index; ///更新 BottomNavigationBar 状态
            }),
        ///设置不可滑动
//          physics: NeverScrollableScrollPhysics(),
        ),
      );
  }

}
