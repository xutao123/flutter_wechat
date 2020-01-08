import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wechat/redux/AppState.dart';
import 'package:flutter_wechat/view/TitlessScaffold.dart';

class DemoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoState();
  }
}

class DemoState extends State<DemoView> {
  bool _switchState = false;
  bool _checkState = false;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _pwdEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TitlessScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("Widget测试Demo", style: TextStyle(fontSize: 20),)),
            Padding(padding: EdgeInsets.only(top: 10),),
            buildSwitchCheck(),
            Padding(padding: EdgeInsets.only(top: 10),),
            buildTextField(),
            Padding(padding: EdgeInsets.only(top: 10),),
            buildFormLogin(),
            Padding(padding: EdgeInsets.only(top: 10),),
            buildWrap(),

          ],
        ),
      ),
    );
  }

  /// Switch CheckBox
  Widget buildSwitchCheck() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Switch(
            onChanged: (bool) {
              /// onChanged是一个参数是boolean类型的函数
              setState(() {
                _switchState = bool;
              });
            },
            value: _switchState,
          ),
          Text(_switchState ? "开" : "关"),
          Checkbox(
              value: _checkState,
              onChanged: _switchState
                  ? (bool) {
                      setState(() {
                        _checkState = bool;
                      });
                    }
                  : null),
          Text(_switchState ? "可以勾选" : "不可勾选"),
        ],
      ),
    );
  }

  /// TextField
  Widget buildTextField() {
    return StoreConnector<AppState, Color>(
        converter: (store) => store.state.themeColor,
        builder: (context, themeColor) {
          return Container(
            width: 300,
            height: 60,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),

                /// 和设置的主题色保持一致
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: themeColor)),
              ),
              controller: _textEditingController,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              onEditingComplete: () => print("onEditingComplete 内容：${_textEditingController.text}"),
              onChanged: (value) => print("onChanged 内容：$value"),
              onSubmitted: (value) => print("onSubmitted 内容：$value"),
              onTap: () => print("onTap 内容"),
            ),
          );
        });
  }

  /// Form FormField
  Widget buildFormLogin() {
    return Form(
      autovalidate: true,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _nameEditingController,
              decoration: InputDecoration(
                hintText: "请输入用户名",
                icon: Icon(Icons.person),
              ),
              validator: (value) => value.trim().length > 0 ? null : "用户名不能为空",
            ),
            TextFormField(
              autofocus: false,
              controller: _pwdEditingController,
              decoration: InputDecoration(
                hintText: "请输入密码",
                icon: Icon(Icons.lock),
              ),
              validator: (value) => validatorPwd(value),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(
                children: <Widget>[
                  Expanded(
                    /// 使用Builder来构建Widget,此时使用的context是Widget构建节点的context
                    /// 不能直接使用Widget，需要使用Builder来构建此时的Widget才正确
                    child: Builder(
                      builder: (context) => RaisedButton(
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "登录",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          if (Form.of(context).validate()) {
                            print("登录成功");
                          } else {
                            print("登录失败");
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String validatorPwd(String value) {
    var len = value.trim().length;
    if (len < 6) {
      return "密码不能小于6位";
    } else if (len > 10) {
      return "密码不能大于10位";
    }
    return null;
  }

  Widget buildWrap() {
    return Wrap( //相对于Row和Column是可以换行和指定方向的
      spacing: 10, // 主轴(水平)方向间距
      runSpacing: 10, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        new Chip(
          avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: new Text('Hamilton'),
        ),
        new Chip(
          avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
          label: new Text('Lafayette'),
        ),
        new Chip(
          avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
          label: new Text('Mulligan'),
        ),
        new Chip(
          avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: new Text('Laurens'),
        ),
      ],
    );
  }
}
