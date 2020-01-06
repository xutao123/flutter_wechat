import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_wechat/redux/AppState.dart';
import 'package:flutter_wechat/util/SizeUtil.dart' as SizeUtil;
import 'package:flutter/gestures.dart' show DragStartBehavior;

///不包含状态栏的Scaffold
class TitlessScaffold extends StatefulWidget {

    final bool extendBody;

    /// An app bar to display at the top of the scaffold.
    final PreferredSizeWidget appBar;

    /// The primary content of the scaffold.
    final Widget body;

    final Widget floatingActionButton;

    final FloatingActionButtonLocation floatingActionButtonLocation;

    final FloatingActionButtonAnimator floatingActionButtonAnimator;

    final List<Widget> persistentFooterButtons;

    final Widget drawer;

    final Widget endDrawer;

    final Color drawerScrimColor;

    final Color backgroundColor;

    final Widget bottomNavigationBar;

    final Widget bottomSheet;

    @Deprecated('Use resizeToAvoidBottomInset to specify if the body should resize when the keyboard appears')
    final bool resizeToAvoidBottomPadding;

    final bool resizeToAvoidBottomInset;

    final bool primary;

    /// {@macro flutter.material.drawer.dragStartBehavior}
    final DragStartBehavior drawerDragStartBehavior;
    /// 20.0 will be added to `MediaQuery.of(context).padding.left`.
    final double drawerEdgeDragWidth;

    TitlessScaffold({
        Key key,
        this.appBar,
        this.body,
        this.floatingActionButton,
        this.floatingActionButtonLocation,
        this.floatingActionButtonAnimator,
        this.persistentFooterButtons,
        this.drawer,
        this.endDrawer,
        this.bottomNavigationBar,
        this.bottomSheet,
        this.backgroundColor,
        this.resizeToAvoidBottomPadding,
        this.resizeToAvoidBottomInset,
        this.primary = true,
        this.drawerDragStartBehavior = DragStartBehavior.start,
        this.extendBody = false,
        this.drawerScrimColor,
        this.drawerEdgeDragWidth,
    }) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TitlessState();
  }
}

class TitlessState extends State<TitlessScaffold> {
  @override
  Widget build(BuildContext context) {
      /// 通过StoreConnector将AppState与builder中的Widget结合
      /// <AppState,Color>：AppStated定义状态，Color是AppState中的某一个属性的类型，下面这个Widget中需要使用这个属性
    return StoreConnector<AppState, Color> (
        ///获得定义的属性，给下面的Widget使用，值对应赋值给下面builder中的themeColor
        /// 这个值的改变请看SettingView中
      converter: (store) => store.state.themeColor,
        /// themeColor来自converter中从store中取出的值
        builder:(context, themeColor) {
           return Scaffold(
                appBar: PreferredSize(
                    //顶部放置一个预留的高度
                    preferredSize: Size.fromHeight(
                        SizeUtil.getAppbarHeight(context)),
                    child: Container(
                        width: double.infinity,
                        height: SizeUtil.getAppbarHeight(context),
                        color: themeColor
                    ),
                ),
                body: widget.body, //不设置appBar时，可以在这上面加一个SafeArea，但是无法修改状态栏的颜色
            );
        },
    );
  }

}