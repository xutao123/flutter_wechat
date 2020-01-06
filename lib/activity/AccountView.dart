import 'package:flutter/material.dart';
import 'package:flutter_wechat/view/TitlessScaffold.dart';

///用户账户修改页面
class AccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountState();
  }
}

class AccountState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return TitlessScaffold(
        backgroundColor: Colors.white,
        body: Column(
            children: <Widget>[
                buildTitle(),
                buildAvator(),
                Container(height: 1, color: Colors.grey[200],),
                buildName(),
                Container(height: 1, color: Colors.grey[200],),
            ],
        ),
    );
  }

  Widget buildTitle() {
      return Container(
        height: 60,
        color: Colors.grey[200],
        child: Stack(
            children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(alignment: Alignment.centerLeft,child: Icon(Icons.arrow_back)),
                ),
                Align(alignment: Alignment.center,child: Text("个人信息",style: TextStyle(color: Colors.black, fontSize: 22),)),
            ],
        ),
      );
  }

  Widget buildAvator() {
      return Container(
        height: 80,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child:Text("头像", style: TextStyle(fontSize: 20, color: Colors.black),),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Image(image: AssetImage("images/avatar_0.png"), width: 60, height: 60),
                ),
            ],
        ),
      );
  }

  Widget buildName() {
      return Container(
          height: 60,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child:Text("名字", style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text("原来足球是圆的", style: TextStyle(fontSize: 20, color: Colors.black),),
                  ),
              ],
          ),
      );
  }

}


