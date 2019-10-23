import 'package:bay_search_books/app/navigations/SlideRightPageRoute.dart';
import 'package:bay_search_books/app/pages/Home.dart';
import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:bay_search_books/app/ui-items/BayAppBar.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  final TextEditingController searchController;

  const SearchAppBar({
    Key key,
    @required this.searchController,
  })  : assert(searchController != null),
        super(key: key);
  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  bool searchMode = false;
  var title = '';

  @override
  void initState() {
    title = widget.searchController.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _main;

    if (!searchMode) {
      _main = <Widget>[
        Expanded(
          child: (title.isNotEmpty)
              ? Text(
                  title,
                  style: TextStyle(
                    color: BayColors.white,
                    fontSize: 16.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
              : Container(),
        )
      ];
    } else {
      _main = <Widget>[
        Expanded(
          child: TextField(
            autofocus: true,
            controller: widget.searchController,
            style: TextStyle(color: BayColors.white),
            decoration: _textInputDecoration,
            onEditingComplete: () => widget.searchController.text.isEmpty
                ? _searchModeState()
                : Navigator.of(context).pushReplacement(
                    SlideRightPageRoute(
                      builder: (context) =>
                          Home(searchController: widget.searchController),
                    ),
                  ),
          ),
        )
      ];
    }

    return BayAppBar(
      main: _main,
      decoration: BoxDecoration(color: BayColors.blue),
      suffixes: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: BayColors.white,
            size: 20.0,
          ),
          onPressed: _searchModeState,
        ),
      ],
    );
  }

  final _textInputDecoration = InputDecoration.collapsed(
    border: InputBorder.none,
    hintStyle: TextStyle(color: BayColors.white),
    hintText: 'Cari buku...',
  );

  _searchModeState() => setState(() => searchMode = !searchMode);
}
