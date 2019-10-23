import 'package:bay_search_books/app/models/Books.dart';
import 'package:bay_search_books/app/routing/Router.dart';

class BookService {
  Future<Books> getAll(String keyword) =>
      Router(keyword).get().then((response) => Books.fromResponse(response));
}
