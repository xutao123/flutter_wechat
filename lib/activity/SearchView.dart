import 'package:flutter/material.dart';
import 'package:flutter_wechat/util/SizeUtil.dart' as SizeUtil;
import 'package:flutter_wechat/view/TitlessScaffold.dart';

///转场动画 hero
class SearchView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StateSearchView();
  }
}

class StateSearchView extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TitlessScaffold(
      body: buildSearchView(),
    );
  }

  buildSearchView() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  Expanded(child: TextField()),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
