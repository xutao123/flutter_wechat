import 'package:flutter/material.dart';
import 'dart:math' as math;

///flutter提供的用于获取不同平台（Android和IOS）的转态栏的高度
double getAppbarHeight(BuildContext context) {
    EdgeInsets padding = MediaQuery.of(context).padding;
    double top = math.max(padding.top, EdgeInsets.zero.top); //计算状态栏的高度
    return top;
}

double getWidowWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
}
