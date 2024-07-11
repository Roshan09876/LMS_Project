import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:learn_management_system/core/app_routes.dart';

import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/course/datasource/course_remote_datasource.dart';
import 'package:learn_management_system/features/course/presentation/state/course_state.dart';

final courseViewModelProvider =
    StateNotifierProvider<CourseViewModel, CourseState>((ref) {
  return CourseViewModel(ref.read(courseRemoteDatasourceProvider),
      ref.read(flutterSecureStorageProvider));
});

class CourseViewModel extends StateNotifier<CourseState> {
  final CourseRemoteDatasource courseRemoteDatasource;
  final FlutterSecureStorage flutterSecureStorage;
  CourseViewModel(this.courseRemoteDatasource, this.flutterSecureStorage)
      : super(CourseState.initial());

  Future<void> getCourse() async {
    state = state.copyWith(isLoading: true);
    final result = await courseRemoteDatasource.getAllCourse();

    result.fold((failure) {
      state = state.copyWith(isLoading: false, error: failure.error);
    }, (success) {
      state = state.copyWith(isLoading: false, courses: success, error: null);
    });
  }

   Future<void> selectCourse(String courseId, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    
    final result = await courseRemoteDatasource.selectCourse(courseId);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        debugPrint('Error: ${failure.error}');
        EasyLoading.showError('Failed to select course');
      },
      (success) {
        state = state.copyWith(isLoading: false);
        EasyLoading.showSuccess('Course Selected');

        // Check if the widget is still mounted before navigating
        if (mounted) {
          // Navigate to the dashboard after selecting the course
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushNamed(context, AppRoute.dashboardViewRoute);
            EasyLoading.dismiss();
          });
        }
      },
    );
  }

  // Future<void> selectCourse(
  //     String courseId, BuildContext context) async {
  //   state = state.copyWith(isLoading: true);
  //   final result = await courseRemoteDatasource.selectCourse(courseId);

  //   result.fold((failure) {
  //     state = state.copyWith(isLoading: false, error: failure.error);
  //     debugPrint('Error: ${failure.error}');
  //   }, (success) async {
  //     state = state.copyWith(isLoading: false);
  //      EasyLoading.show(status: 'Course Selected',);
  //     Future.delayed(const Duration(seconds: 2), () {
  //       Navigator.pushReplacementNamed(context, AppRoute.bottomViewRoute);
  //       EasyLoading.dismiss();
  //     });
  //   });
  // }
}
