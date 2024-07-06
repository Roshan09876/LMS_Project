import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:learn_management_system/features/course/presentation/view/select_course.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final authState = ref.watch(authViewModelProvider);
        

        if (authState.currentUser.selectedCourse == null ||
            authState.currentUser.selectedCourse!.isEmpty) {
          return SelectCourseView();
        } else {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  color: kMilkLight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 300),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Card(
                              child: Text('fghjm'),
                            ),
                            Card(
                              child: Text('fghjm'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: kButton,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: 'LearnEase',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: kLight,
                              ),
                              ReusableText(
                                text:
                                    'Welcome ${authState.currentUser.fullName}',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kLight,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 130.0,
                          height: 130.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 5,
                  right: 0,
                  top: 220,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.remove,
                              color: kDark,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: kLight),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
