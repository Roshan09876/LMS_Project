import 'package:learn_management_system/choose_course.dart';
import 'package:learn_management_system/core/test.dart';
import 'package:learn_management_system/features/auth/presentation/view/getting_started.dart';
import 'package:learn_management_system/features/auth/presentation/view/login_view.dart';
import 'package:learn_management_system/features/auth/presentation/view/register_view.dart';
import 'package:learn_management_system/features/home/dashboard_view.dart';
import 'package:learn_management_system/features/home/presentation/view/bottom_view.dart';
import 'package:learn_management_system/features/profile/presentation/widgets/edit_profile.dart';

class AppRoute {
  AppRoute._();

  static const String bottomViewRoute = '/bottomViewRoute';
  static const String registerViewRoute = '/registerviewroute';
  static String loginViewRoute = '/loginViewRoute';
  static String chooseCourseRoute = '/chooseCourseRoute';
  static String gettingStartedRoute = '/gettingStartedRoute';
  static String dashboardViewRoute = '/dashboardViewRoute';
  static String testViewRoute = '/testViewRoute';
  static String editprofileViewRoute = '/editprofileViewRoute';

  static getApplicationRoute() {
    return {
      registerViewRoute: (context) => const RegisterView(),
      gettingStartedRoute: (context) => const GettingStarted(),
      loginViewRoute: (context) => const LoginView(),
      dashboardViewRoute: (context) => const DashboardView(),
      bottomViewRoute: (context) => BottomView(),
      chooseCourseRoute: (context) => const ChooseCourse(),
      testViewRoute: (context) => const Test(),
      editprofileViewRoute: (context) => const EditProfileView(),
    };
  }
}
