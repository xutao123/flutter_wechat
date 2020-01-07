import 'package:flutter/material.dart';
import 'package:flutter_wechat/view/TitlessScaffold.dart';

class DemoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoState();
  }
}

class DemoState extends State<DemoView> {
  bool _switchState = false;
  bool _canCheck = false;
  bool _checkState = false;

  @override
  Widget build(BuildContext context) {
    return TitlessScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(child: Text("Widget测试Demo", style: TextStyle(fontSize: 20),)),
          Padding(padding: EdgeInsets.only(top: 10),),
          buildSwitchCheck(),
        ],
      ),
    );
  }

  /// 创建开关和选择框
  Widget buildSwitchCheck() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Switch(
            onChanged: (bool) { /// onChanged是一个参数是boolean类型的函数
              setState(() {
                _switchState = bool;
              });
            },
            value: _switchState,
          ),
          Text(_switchState ? "开" : "关"),
          Checkbox(value: _checkState, onChanged: _switchState ? (bool){setState(() {
            _checkState = bool;
          });} : null),
          Text(_switchState ? "可以勾选" : "不可勾选"),
        ],
      ),
    );
  }

}
