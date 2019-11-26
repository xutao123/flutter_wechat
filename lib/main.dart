import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wechat/NavWidget.dart';
import 'package:flutter_wechat/view/TitlessScaffold.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'redux/AppState.dart';

void main() {
  runApp(MyApp());
  // 设置状态栏透明
  if (Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends StatelessWidget {
  /// 创建Store，引用 AppState 中的 appReducer 创建 Reducer
  /// initialState 初始化 State
  final appStore = Store<AppState>(
    appReducer,

    ///返回AppState的方法，在AppState中定义
    initialState: AppState(themeColor: Colors.blue),
  );

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      /// 后面通过StoreProvider将store和Widget联系起来，详细说明请看TitlessScaffold中
      store: appStore,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return TitlessScaffold(
      body: NavWidget(), //不设置appBar时，可以在这上面加一个SafeArea，但是无法修改状态栏的颜色
    );
  }
}
