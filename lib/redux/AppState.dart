import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class AppState { ///可以定义多个State状态属性,这里只定义了一个
    Color themeColor;
    AppState({this.themeColor});
}

AppState appReducer(AppState state, dynamic action) { ///每一个State都由一个Reducer来产生返回，action任意类型，可以忽略dynamic
    return AppState(themeColor: ThemeDataReducer(state.themeColor, action));
}

///随着应用变得复杂，需要对 reducer 函数 进行拆分，拆分后的每一块独立负责管理 state 的一部分
///每个Reducer只能返回一个状态，使用flutter_redux中的combineReducers来整合多个Reducer
///通过combineReducers和TypedReducer将我们的Action和_refresh方法进行绑定，_refresh方法返回一个新的State
final ThemeDataReducer = combineReducers<Color>([
    ///将RefreshThemeDataAction与_refresh方法绑定，即action是RefreshThemeDataAction 使用_refresh来处理
    TypedReducer<Color, RefreshThemeDataAction>(_refresh),
    ///可以添加其他的Action和相关方法
]);

Color _refresh(Color themeColor, action) {
    ///将Action，处理Action动作的方法，State绑定
    ///根据Action的不同返回不同的State对象，这里的Action主要是带有不同ThemeData的对象(RefreshThemeDataAction)
    ///因此，这里主要是取出之后赋值给App中存储的State对象，从而根据在任何地方新给的ThemeData对象来跟新App的主题
    themeColor = action.themeColor;
    return themeColor;
}

///定义一个 Action 类
///将该 Action 在 Reducer 中与处理该Action的方法绑定
class RefreshThemeDataAction {
    final Color themeColor;
    RefreshThemeDataAction(this.themeColor);
}