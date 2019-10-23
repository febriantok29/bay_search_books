import 'package:bay_search_books/app/models/Books.dart';
import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:bay_search_books/app/services/BookService.dart';
import 'package:bay_search_books/app/ui-items/BookCard.dart';
import 'package:bay_search_books/app/ui-items/SearchAppBar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final TextEditingController searchController;

  const Home({
    Key key,
    @required this.searchController,
  })  : assert(searchController != null),
        super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _service = BookService();
  Future<Books> _books;

  @override
  void initState() {
    _books = _service.getAll(widget.searchController.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BayColors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            SearchAppBar(
              searchController: widget.searchController,
            ),
            Flexible(
              child: Center(
                child: FutureBuilder<Books>(
                  future: _books,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) return Text('${snapshot.error}');

                    if (snapshot.hasData) {
                      final data = snapshot.data;

                      if (data.totalItem != 0 && data.items.isNotEmpty)
                        return _buildContent(data);

                      return Text(
                        "No results found for '${widget.searchController.text}'",
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContent(Books books) {
    return ListView(
      padding: const EdgeInsets.all(15.0),
      children: books.items
          .map((book) => Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: BookCard(
                    book: book,
                    minHeight: (MediaQuery.of(context).size.width) / 2.0),
              ))
          .toList(),
    );
  }
}
