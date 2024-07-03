import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';
import 'package:learn_management_system/features/profile/presentation/view_model/profile_view_model.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  //  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     await ref.read(profileViewModelProvider.notifier).getProfile();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileViewModelProvider);
    final profile = profileState.users!.first;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: kButton,
          title: const ReusableText(
              text: 'Settings',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: kLight),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Card(
                color: Color(kButton.value),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 50,
                          backgroundImage:
                              profile.image != null && profile.image!.isNotEmpty
                                  ? NetworkImage(profile.image!)
                                  : AssetImage('assets/images/login_icon.png'),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ReusableText(
                          text: '${profile.userName}'.toUpperCase(),
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(kLight.value))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SettingsGroup(items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.edit,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Edit Profile',
                  subtitle: "Update",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.repeat,
                  title: "Change Password",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.fingerprint,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Biometric Authentication',
                  subtitle: "Toggle",
                  trailing: Switch.adaptive(
                    value: true,
                    onChanged: (value) {},
                  ),
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Ziar'App",
                ),
              ]),
              SettingsGroup(
                settingsGroupTitle: 'Account',
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
