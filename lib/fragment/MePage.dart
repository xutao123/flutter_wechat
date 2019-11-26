import 'package:flutter/material.dart';
import 'package:flutter_wechat/activity/SettingView.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MePageState();
  }
}

class MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        buildSettingItem(),
      ],
    );
  }

  GestureDetector buildSettingItem() {
    return GestureDetector(
        /// onTap是一个Function
        /// 最好写成() => function()的方式，不能直接写function()，可能出现该方法只在init时调用一次，之后点击不调用
        /// 目前上述情况只在这边出现了，在WeChatListPage中两次调用未出现
        onTap: () => _clickSetting(),
        child: Container(
          height: 60,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: 20)),
              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.settings, color: Colors.blue),
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              Expanded(child: Text("设置")),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_right, color: Colors.grey),
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
            ],
          ),
        ),
      );
  }

  _clickSetting() => Navigator.push(context, MaterialPageRoute(builder: (context) => SettingView()));

}


