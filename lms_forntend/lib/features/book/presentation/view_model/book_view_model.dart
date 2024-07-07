import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/features/book/datasource/book_remote_datasource.dart';
import 'package:learn_management_system/features/book/presentation/state/book_state.dart';

final bookViewModelProvider =
    StateNotifierProvider<BookViewModel, BookState>((ref) {
  return BookViewModel(
      bookRemoteDatasource: ref.read(bookRemoteDatasourceProvider));
});

class BookViewModel extends StateNotifier<BookState> {
  final BookRemoteDatasource bookRemoteDatasource;
  BookViewModel({required this.bookRemoteDatasource})
      : super(BookState.initial());

  Future<void> getBeginnerBook() async {
    state = state.copyWith(isLoading: true);
    final result = await bookRemoteDatasource.getBeginnerLevelBooks();
    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
    }, (success) {
      state = state.copyWith(isLoading: false, books: success);
    });
  }
}
