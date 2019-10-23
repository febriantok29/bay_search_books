import 'package:bay_search_books/app/models/Book.dart';

class Books {
  int totalItem;
  List<Book> items;

  Books({
    this.totalItem,
    this.items,
  });

  Books.fromResponse(Map<String, dynamic> response) {
    totalItem = response['totalItems'];

    items = [];
    if (response.containsKey('items') && response['items'] != null) {
      final bookData = response['items'] as List;

      for (final item in bookData) items.add(Book.fromResponse(item));
    }
  }
}
