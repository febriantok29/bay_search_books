import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BayAppBar extends StatelessWidget {
  final List<Widget> main;
  final List<Widget> suffixes;
  final double appBarHeight;
  final BoxDecoration decoration;

  const BayAppBar({
    Key key,
    this.appBarHeight = 60.0,
    this.decoration,
    this.main,
    this.suffixes,
  })  : assert(appBarHeight != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;

    final _prefixes = <Widget>[
      IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: BayColors.white,
            size: 32.0,
          ),
          onPressed: () => Navigator.of(context).pop())
    ];

    final _suffixes = List.from(suffixes) ?? <Widget>[];
    final List<Widget> _main = List.from(main) ?? <Widget>[];

    final appBarContent = <Widget>[
      ..._prefixes,
      ..._main,
      ..._suffixes,
    ];

    return Container(
      height: appBarHeight + statusBarHeight,
      padding: EdgeInsets.only(top: statusBarHeight),
      decoration: decoration,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: appBarContent,
        ),
      ),
    );
  }
}
