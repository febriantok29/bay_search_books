import 'package:bay_search_books/app/models/Book.dart';
import 'package:bay_search_books/app/navigations/SlideRightPageRoute.dart';
import 'package:bay_search_books/app/pages/BookDetails.dart';
import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:bay_search_books/app/ui-items/BayStarRating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class BookCard extends StatelessWidget {
  final Book book;
  final double minHeight;

  const BookCard({
    Key key,
    this.book,
    this.minHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        SlideRightPageRoute(
          builder: (context) => BookDetails(
            book: book,
            minHeight: minHeight,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10.0),
        constraints:
            minHeight == null ? null : BoxConstraints(minHeight: minHeight),
        decoration: BoxDecoration(
          color: BayColors.white,
          border: Border(
            bottom: BorderSide(width: .2),
          ),
        ),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    final _thumbnailSection = Flexible(
      child: Hero(
        tag: book.heroKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: book.thumbnail,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );

    final _informationItems = <Widget>[
      Text(
        book.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    ];

    if (book.author != null && book.author.isNotEmpty)
      _informationItems.add(
        Text(
          book.author,
          style: TextStyle(
            fontSize: 12.0,
            color: BayColors.grey,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );

    if (book.rating != 0.0)
      _informationItems.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 5.0,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: BayStarRating(rating: book.rating),
              ),
              Expanded(child: Text('${book.rating}')),
            ],
          ),
        ),
      );

    if (book.description != null && book.description.isNotEmpty)
      _informationItems.add(
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              book.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );

    final _informationSection = Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _informationItems,
        ),
      ),
    );

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _thumbnailSection,
          _informationSection,
        ],
      ),
    );
  }
}
