import 'package:flutter/material.dart';

///通讯录
class ChatContactPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ChatContactPageState();
  }
}

/// Flutter 在Tab中切换View时会重新创建调用initState，
/// 保存View状态：添加AutomaticKeepAliveClientMixin，重写wantKeepAlive，在build中调用super.builder
class ChatContactPageState extends State<ChatContactPage> with AutomaticKeepAliveClientMixin {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
      super.build(context);
    // TODO: implement build
    return GestureDetector(
      onTap: () => setState(() => _count++),
      child: Text(
          "联系人$_count"
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
