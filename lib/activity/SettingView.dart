import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wechat/redux/AppState.dart';
import 'package:flutter_wechat/view/TitlessScaffold.dart';

///设置页面
class SettingView extends StatefulWidget {
  @override
  State createState() => new StateSetting();
}

class StateSetting extends State<SettingView> {
    ThemeDatas _curThemeData;

  @override
  Widget build(BuildContext context) {
      if (_curThemeData == null) {
          /// 获取store中的值必须在initState之后，否则报错
          Color initColor = StoreProvider.of<AppState>(context).state.themeColor;
          if (initColor == Colors.pink) {
              _curThemeData = ThemeDatas.pink;
          } else {
              _curThemeData = ThemeDatas.blue;
          }
      }
    return TitlessScaffold(
        body: Column(
            children: <Widget>[
                RadioListTile(value: ThemeDatas.pink, groupValue: _curThemeData,
                    title: Text("粉红"), activeColor: Colors.pink,
                    onChanged: (value) => selectTheme(ThemeDatas.pink)),
                RadioListTile(value: ThemeDatas.blue, groupValue: _curThemeData,
                    title: Text("蓝色"), activeColor: Colors.blue,
                    onChanged: (value) => selectTheme(ThemeDatas.blue)),
            ],
        ),
    );
  }

  selectTheme(value) {
      this.setState(() => _curThemeData = value);
      Color primaryColor;
      switch(value) {
          case ThemeDatas.pink:
              primaryColor = Colors.pink;
              break;
          case ThemeDatas.blue:
              primaryColor = Colors.blue;
              break;
          default:
              primaryColor = Colors.orange;
              break;
      }
      /// 修改全局状态AppState中的themeColor属性值，通过RefreshThemeDataAction这个Action，
      /// 这个值在TitlessSacffold中使用，修改状态栏的颜色值
      /// of需要带上泛型类型，否则会报错
      StoreProvider.of<AppState>(context).dispatch(RefreshThemeDataAction(primaryColor));
  }
}

enum ThemeDatas {
    pink,
    blue,
}
