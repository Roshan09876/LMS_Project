import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/features/book/presentation/state/book_state.dart';
import 'package:learn_management_system/features/competedbook/data/datasource/book_complter_remote_datasource.dart';
import 'package:learn_management_system/features/competedbook/data/model/book_completed_model.dart';
import 'package:learn_management_system/features/competedbook/presentation/state/book_complted_state.dart';

final bookCompletedViewModelProvider =
    StateNotifierProvider<BookCompletedViewModel, BookCompltedState>((ref) {
  return BookCompletedViewModel(
      bookComplterRemoteDatasource:
          ref.read(bookComplterRemoteDatasourceProvider));
});

class BookCompletedViewModel extends StateNotifier<BookCompltedState> {
  final BookComplterRemoteDatasource bookComplterRemoteDatasource;
  BookCompletedViewModel({required this.bookComplterRemoteDatasource})
      : super(BookCompltedState.initial());

  Future<void> fetchCompletedBooks() async {
    state = state.copyWith(
      isLoading: true,
      error: null,
    );
    final result = await bookComplterRemoteDatasource.getCompletedBook();
    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
      },
      (books) {
        state = state.copyWith(isLoading: false, bookCompletedModel: books);
      },
    );
  }
}
