import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';

class CourseView extends ConsumerWidget {
  const CourseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kButton,
          title: const ReusableText(
              text: 'Courses',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kLight)),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return const Card(
              elevation: 2,
                child: ReusableText(
                    text: 'Lessons',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kDark));
          }),
    );
  }
}
