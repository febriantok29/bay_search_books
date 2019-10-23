import 'package:bay_search_books/app/models/Book.dart';
import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:bay_search_books/app/ui-items/BayStarRating.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetails extends StatefulWidget {
  final Book book;
  final double minHeight;

  const BookDetails({
    Key key,
    this.book,
    this.minHeight,
  }) : super(key: key);

  @override
  _BookDetailsState createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BayColors.white,
      appBar: AppBar(
        backgroundColor: BayColors.blue,
        title: Text(
          widget.book.title,
          style: TextStyle(
            color: BayColors.white,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        children: <Widget>[
          _buildHeader(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    final _bookThumbnail = Flexible(
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Hero(
          tag: widget.book.heroKey,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: BayColors.grey,
                  offset: Offset(0.0, 3.0),
                ),
              ],
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image(
                image: widget.book.thumbnail,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );

    final _bookInformation = _buildBookInformation();

    final _seeDetailsBtn = Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: RaisedButton(
        color: BayColors.blue,
        onPressed: () async {
          final url = widget.book.link;
          if (url != null && url.isNotEmpty && await canLaunch(url))
            await launch(url);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.book,
                color: BayColors.white,
              ),
            ),
            Flexible(
              child: Text(
                'Lihat Selengkapnya',
                style: TextStyle(
                  color: BayColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Column(
        children: <Widget>[
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _bookThumbnail,
                _bookInformation,
              ],
            ),
          ),
          _seeDetailsBtn,
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tentang Buku Ini',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(padding: const EdgeInsets.only(bottom: 8.0)),
          if (widget.book.description != null)
            Text(widget.book.description)
          else
            Text('Deskripsi tidak tersedia'),
        ],
      ),
    );
  }

  Widget _buildBookInformation() {
    final _informationItems = <Widget>[
      Text(
        widget.book.title,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      )
    ];

    if (widget.book.subtitle != null && widget.book.subtitle.isNotEmpty)
      _informationItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: Text(
            widget.book.subtitle,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: BayColors.grey,
            ),
          ),
        ),
      );

    if (widget.book.author != null && widget.book.author.isNotEmpty)
      _informationItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            widget.book.author,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16.0,
              color: BayColors.blue,
            ),
          ),
        ),
      );

    if (widget.book.publisher != null && widget.book.publisher.isNotEmpty)
      _informationItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 2.5),
          child: Text(
            widget.book.publisher,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );

    if (widget.book.category != null && widget.book.category.isNotEmpty)
      _informationItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Text('Genre: ${widget.book.category}'),
        ),
      );
    if (widget.book.rating != 0.0)
      _informationItems.add(
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: BayStarRating(rating: widget.book.rating),
              ),
              Expanded(child: Text('${widget.book.rating}')),
            ],
          ),
        ),
      );

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _informationItems,
      ),
    );
  }
}
