import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/core/app_routes.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/core/provider/flutter_secure_storage_provider.dart';
import 'package:learn_management_system/features/auth/presentation/view_model/auth_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final key = GlobalKey<FormState>();
  bool _obsecureText = true;
  bool? rememberMe = false;
  final _gap = const SizedBox(
    height: 15,
  );
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
    String? savedUserName = await flutterSecureStorage.read(key: 'userName');
    String? savedPassword = await flutterSecureStorage.read(key: 'password');

    if (savedUserName != null) {
      setState(() {
        _userNameController.text = savedUserName;
        rememberMe = true;
      });
    }

    if (savedPassword != null) {
      setState(() {
        _passwordController.text = savedPassword;
      });
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> saveCredentials(String userName, String password) async {
    final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
    await flutterSecureStorage.write(key: 'userName', value: userName);
    await flutterSecureStorage.write(key: 'password', value: password);
  }

  void _onRemembermeTapped(bool newValue) async {
    if (newValue) {
      if (_userNameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        await saveCredentials(
            _userNameController.text, _passwordController.text);
      }
    } else {
      final flutterSecureStorage = ref.read(flutterSecureStorageProvider);
      await flutterSecureStorage.delete(key: 'userName');
      await flutterSecureStorage.delete(key: 'password');
    }
    setState(() {
      rememberMe = newValue;
    });
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
                  padding: const EdgeInsets.only(left: 180),
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/login_icon.png'))),
                  ),
                ),
                _gap,
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
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: rememberMe ?? false,
                              onChanged: (value) {
                                _onRemembermeTapped(value!);
                              }),
                          ReusableText(
                              text: 'Remember me',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: kButton),
                        ],
                      )
                    ],
                  ),
                ),
                // _gap,
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
                        text: 'SignUp',
                        color: kButton,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
