import 'package:bay_search_books/app/resources/BayColors.dart';
import 'package:flutter/material.dart';

class StarIconSet {
  final IconData full;
  final IconData half;
  final IconData empty;
  final Color fillColor;
  final Color emptyColor;
  final double size;

  const StarIconSet({
    this.full = Icons.star,
    this.half = Icons.star_half,
    this.empty = Icons.star_border,
    this.fillColor = BayColors.yellow,
    this.emptyColor = BayColors.grey,
    this.size = 16.0,
  });
}

class BayStarRating extends StatefulWidget {
  final double rating;
  final StarIconSet star;

  const BayStarRating({
    Key key,
    @required this.rating,
    this.star = const StarIconSet(),
  }) : super(key: key);

  @override
  _BayStarRatingState createState() => _BayStarRatingState();
}

class _BayStarRatingState extends State<BayStarRating> {
  final maxRating = 5;
  final stars = <Widget>[];

  @override
  Widget build(BuildContext context) {
    if (stars.length != maxRating) _buildStars();
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: stars);
  }

  void _buildStars() {
    var fullStars = 0, emptyStars = 0, halfStar = false;

    final adjustedRating = (widget.rating * 2).round() / 2.0;
    fullStars = adjustedRating.truncate();
    halfStar = (adjustedRating - fullStars) != 0.0;
    emptyStars = maxRating - fullStars - (halfStar ? 1 : 0);

    for (var i = 0; i < fullStars; i++) {
      stars.add(Icon(
        widget.star.full,
        color: widget.star.fillColor,
        size: widget.star.size,
      ));
    }

    if (halfStar) {
      stars.add(Icon(
        widget.star.half,
        color: widget.star.fillColor,
        size: widget.star.size,
      ));
    }

    for (var i = 0; i < emptyStars; i++) {
      stars.add(Icon(
        widget.star.empty,
        color: widget.star.emptyColor,
        size: widget.star.size,
      ));
    }
  }
}
