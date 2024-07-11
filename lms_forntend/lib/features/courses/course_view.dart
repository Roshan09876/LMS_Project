import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/book/model/book_model.dart';
import 'package:learn_management_system/features/book/presentation/view_model/book_view_model.dart';

class CourseView extends ConsumerStatefulWidget {
  const CourseView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourseViewState();
}

class _CourseViewState extends ConsumerState<CourseView> {
  final _heightgap = SizedBox(
    height: 15,
  );

  @override
  Widget build(BuildContext context) {
    final easyState = ref.watch(bookViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: ReusableText(
          text: 'Courses',
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        backgroundColor: Color(kButton.value),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: ReusableText(
                  text: 'Feel free to choose a course at any level',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(kButton.value)),
            ),
            _heightgap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    ref.read(bookViewModelProvider.notifier).getEasyBook();
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Card(
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Color(kButton.value),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                AssetImage('assets/icons/easy.png'),
                          ),
                          ReusableText(
                              text: 'Easy',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(kLight.value)),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(kButton.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/icons/medium.png'),
                        ),
                        ReusableText(
                            text: 'Medium',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(kLight.value)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(kButton.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage('assets/icons/hard.png'),
                        ),
                        ReusableText(
                            text: 'Hard',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(kLight.value)),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  child: Card(
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: Color(kButton.value),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/icons/advance.png'),
                        ),
                        ReusableText(
                            text: 'Advance',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(kLight.value)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _heightgap,
            Align(
              alignment: Alignment.topLeft,
              child: ReusableText(
                  text: 'Tutorial Video to learn',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(kButton.value)),
            ),
            Expanded(
              child: easyState.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : easyState.error != null
                      ? Center(
                          child: Text('Error: ${easyState.error}'),
                        )
                      : ListView.builder(
                          itemCount: easyState.books.length,
                          itemBuilder: (context, index) {
                            BookModel book = easyState.books[index];
                            return ListTile(
                              title: Text(
                                book.title ?? '',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }),
            )
          ],
        ),
      ),
    );
  }
}
