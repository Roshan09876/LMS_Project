import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/features/course/datasource/course_remote_datasource.dart';
import 'package:learn_management_system/features/course/presentation/state/course_state.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(ref.read(courseRemoteDatasourceProvider));
});

class CourseViewModel extends StateNotifier<CourseState> {
  final CourseRemoteDatasource courseRemoteDatasource;
  CourseViewModel(this.courseRemoteDatasource) : super(CourseState.initial());

  Future<void> getCourse() async {
    state = state.copyWith(isLoading: true);
    final result = await courseRemoteDatasource.getAllCourse();

    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
    }, (success) {
      state = state.copyWith(isLoading: false, courses: success, error: null);
    });
  }
}
