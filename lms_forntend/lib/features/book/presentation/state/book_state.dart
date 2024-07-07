// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:learn_management_system/features/book/model/book_model.dart';

class BookState {
  final bool? isLoading;
  final String? error;
  final bool? showMessage;
  List<BookModel> books;

  BookState({this.isLoading, this.error, this.showMessage, required this.books});

  factory BookState.initial() {
    return BookState(
      isLoading: false,
      error: null,
      showMessage: false,
      books: []
    );
  }

  BookState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<BookModel>? books
  }) {
    return BookState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
      books: books ?? this.books
    );
  }
}
