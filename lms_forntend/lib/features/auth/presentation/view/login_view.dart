import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:learn_management_system/features/home/presentation/view_model/home_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final key = GlobalKey<FormState>();
  bool _obsecureText = true;
  final _gap = const SizedBox(
    height: 15,
  );
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Form(
            key: key,
            child: Column(
              children: [
                const ReusableText(
                  text: 'Login',
                  color: kDark,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                _gap,
                _gap,
                _gap,
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/login_icon.png'))),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Username'),
                      Row(
                        children: [
                          const Icon(Icons.verified_outlined), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _userNameController,
                              decoration: const InputDecoration(
                                hintText: 'UserName must be unique',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'please enter UserName';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      const Text('Password'),
                      Row(
                        children: [
                          const Icon(Icons.password_outlined), // Prefix Icon
                          const VerticalDivider(
                            thickness: 1,
                            color: kDark,
                          ), // Vertical Divider
                          Expanded(
                            child: TextFormField(
                              controller: _passwordController,
                              obscureText: _obsecureText,
                              decoration: InputDecoration(
                                  hintText: 'Please Enter your password',
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obsecureText = !_obsecureText;
                                        });
                                      },
                                      child: Icon(_obsecureText
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                              // validator: (value) {
                              //   final numericRegExp =
                              //       RegExp(r'^(?=.*?[0-9]).{8,}$');
                              //   if (value!.isEmpty) {
                              //     return 'please Enter Password';
                              //   } else if (value.length < 6) {
                              //     return 'Password must contain 6 letters';
                              //   } else if (!numericRegExp.hasMatch(value)) {
                              //     return 'Password must contain at least one numeric value';
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                          ),
                        ],
                      ),
                      _gap,
                      _gap,
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(330, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: kButton),
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref.read(authViewModelProvider.notifier).login(
                            _userNameController.text.trim(),
                            _passwordController.text.trim(),
                            context);
                      }
                    },
                    child: const ReusableText(
                      text: 'Login',
                      color: kLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login with Biometric'),
                     Icon(Icons.fingerprint),
                  ],
                ),
               
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ReusableText(
                      text: "Don't have an account?",
                      color: kDark,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRoute.registerViewRoute);
                      },
                      child: const ReusableText(
                        text: '  SignUp',
                        color: kButton,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
                _gap,
                _gap,
                 SettingsItem(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.selectcourseViewRoute);
                  },
                  icons: Icons.select_all,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Color(kButton.value),
                  ),
                  title: 'Choose Course',
                  subtitle: "Courses",
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
