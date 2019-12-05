import 'package:flutter/material.dart';
import 'package:flutter_wechat/activity/SettingView.dart';
import 'package:flutter_wechat/util/test.dart' as test;
import 'package:scoped_model/scoped_model.dart';

class MePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MePageState();
  }
}

class MePageState extends State<MePage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
      super.build(context);
    // TODO: implement build
    return Column(
      children: <Widget>[
        buildSettingItem(),
        Padding(
          padding: EdgeInsets.only(top: 10),
        ),
        buildDecompressionItem(),
      ],
    );
  }

  /// ////////////////////////////////////////////////////////////
  ///设置Item
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

  _clickSetting() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingView()));
    test.show();
  }

  /// ////////////////////////////////////////////////////////////
  ///解压Item
  DecompressionCount _countScope = DecompressionCount();

  Widget buildDecompressionItem() {
    return ScopedModel<DecompressionCount>(
      model: _countScope,
      child: GestureDetector(
        onTap: () => _countScope.gotoDecompression(),
        child: Container(
          color: Colors.white,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left:20),
                child: Text("点击解压"),
              ),
              ScopedModelDescendant<DecompressionCount>(
                builder: (context, child, model)
                => Padding(padding: EdgeInsets.only(right: 20), child: Text("解压了${model.count}")),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

// ignore: missing_method_parameters
///scoped_model做状态管理时用于存储state数据的Model
class DecompressionCount extends Model {
  int _count = 0;

  int get count => _count;

  static DecompressionCount of(BuildContext context) => ScopedModel.of<DecompressionCount>(context);

  gotoDecompression() {
    _count++;
    notifyListeners();
  }
}
