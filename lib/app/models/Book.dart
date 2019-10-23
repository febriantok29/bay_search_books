import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';

class Book {
  String tag,
      title,
      subtitle,
      author,
      publisher,
      description,
      category,
      publishDate,
      link;
  double rating;
  ImageProvider thumbnail;

  String get heroKey => 'HERO-BOOK-$tag';

  Book({
    this.tag,
    this.title,
    this.subtitle,
    this.author,
    this.publisher,
    this.description,
    this.category,
    this.publishDate,
    this.link,
    this.rating,
    this.thumbnail,
  });

  Book.fromResponse(Map<String, dynamic> response) {
    rating = 0.0;
    thumbnail = const AssetImage('assets/no-thumbnail-available.png');

    if (response.containsKey('etag')) tag = response['etag'];

    if (response.containsKey('volumeInfo')) {
      final bookInformation = response['volumeInfo'];

      if (bookInformation.containsKey('title') &&
          bookInformation['title'] != null) title = bookInformation['title'];

      if (bookInformation.containsKey('subtitle') &&
          bookInformation['subtitle'] != null)
        subtitle = bookInformation['subtitle'];

      if (bookInformation.containsKey('publisher') &&
          bookInformation['publisher'] != null)
        publisher = bookInformation['publisher'];

      if (bookInformation.containsKey('publishedDate') &&
          bookInformation['publishedDate'] != null)
        publishDate = bookInformation['publishedDate'];

      if (bookInformation.containsKey('description') &&
          bookInformation['description'] != null)
        description = bookInformation['description'];

      if (bookInformation.containsKey('averageRating') &&
          bookInformation['averageRating'] != null)
        rating = bookInformation['averageRating'];

      if (bookInformation.containsKey('categories') &&
          bookInformation['categories'] != null) {
        final categories = bookInformation['categories'] as List;
        if (categories.isNotEmpty) category = categories.join(', ');
      }

      if (bookInformation.containsKey('imageLinks') &&
          bookInformation['imageLinks'] != null) {
        final image = bookInformation['imageLinks'];
        if (image.containsKey('thumbnail') && image['thumbnail'] != null)
          thumbnail = CachedNetworkImageProvider(image['thumbnail']);
      }

      if (bookInformation.containsKey('authors') &&
          bookInformation['authors'] != null) {
        final authors = bookInformation['authors'] as List;
        if (authors.isNotEmpty) author = authors.join(', ');
      }

      if (bookInformation.containsKey('canonicalVolumeLink') &&
          bookInformation['canonicalVolumeLink'] != null)
        link = bookInformation['canonicalVolumeLink'];
    }
  }
}
