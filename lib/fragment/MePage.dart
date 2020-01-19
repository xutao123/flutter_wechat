import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_wechat/activity/AccountView.dart';
import 'package:flutter_wechat/activity/AnimationView.dart';
import 'package:flutter_wechat/activity/DemoView.dart';
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
    return Column(
      children: <Widget>[
        buildAccountItem(),
        Padding(padding: EdgeInsets.only(top: 10),),
        buildSettingItem(),
        Padding(padding: EdgeInsets.only(top: 10),),
        buildDecompressionItem(),
        Padding(padding: EdgeInsets.only(top: 10),),
        buildDemoItem(),
        Padding(padding: EdgeInsets.only(top: 10),),
        buildAnimationItem(),
      ],
    );
  }

  /// //////////////////////////////////////
  /// 个人信息Item
  Widget buildAccountItem() {
    return GestureDetector(
      onTap: () => _clickAccount(),
      child: Container(
        height: 120,
        color: Colors.white,
        /// 使用Stack和 Align,Position结合使用来设置相对位置
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Image(image: AssetImage("images/avatar_0.png"), width: 70, height: 70),
            ),
            /// 这个Expanded可以使得将前后两个View的占用空间去掉之后，让当前View占满整个剩下的空间
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: buildAccountNormalInfoItem())
            ),
            Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(image: AssetImage("images/qrcode.png"), width: 20, height: 20,),
                  Icon(Icons.arrow_right, size: 25, color: Colors.grey[500],),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAccountNormalInfoItem() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("原来足球是圆的",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
        Padding(padding: EdgeInsets.only(top: 6),),
        Text("id:123123123", style: TextStyle(fontSize: 16,)),
      ],
    );
  }

  _clickAccount() {
    Navigator.push(context, MaterialPageRoute(builder: (Context) => AccountView()));
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
  ///解压Item,测试使用scoped_model来管理转态
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
  bool get wantKeepAlive => true;

  /// 这个页面用于测试各种控件的使用
  Widget buildDemoItem() {
    /// 特别注意，方法只用传方法名，不能加括号，否则该方法不被立刻执行而不是再调用的时候被执行
    /// 方法名（不带括号）作为参数传递给其他方法时，传递的是方法的引用，该方法不会立即执行
    return buildCommonSettingWidget("测试页面", gotoDemo);
  }

  gotoDemo() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DemoView()));
  }

  /// 进入动画Demo界面
  buildAnimationItem() {
    return buildCommonSettingWidget("动画页面", gotoAnimation);
  }

  gotoAnimation() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimationView()));
  }

  Widget buildCommonSettingWidget(String tag, func) {
    return GestureDetector(
      /// 特别注意这边要加括号，否则方法体不会执行
      /// 方法执行语句（带括号）作为参数传递给其他方法时，该方法会立即执行，我们传递过去的是方法的返回值
      onTap: () => func(),
      child: Container(
        height: 60,
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(tag),
                )),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child:Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_right, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}

typedef func = void Function(int i);

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
