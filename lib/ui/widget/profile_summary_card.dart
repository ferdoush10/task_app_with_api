// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_mp/ui/controllers/auth_controller.dart';

import 'package:task_mp/ui/screens/edit_profile_screen.dart';
import 'package:task_mp/ui/screens/login_screen.dart';

class ProfileSummaryCard extends StatefulWidget {
  const ProfileSummaryCard({
    Key? key,
    this.enabledOnTap = true,
  }) : super(key: key);

  final bool enabledOnTap;

  @override
  State<ProfileSummaryCard> createState() => _ProfileSummaryCardState();
}

class _ProfileSummaryCardState extends State<ProfileSummaryCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.enabledOnTap) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const EditProfileScreen()));
        }
      },
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(
        // AuthController.user?.firstName ?? ""
        fullName,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        AuthController.user?.email ?? "",
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: IconButton(
          onPressed: () async {
            await AuthController.clearAuthData();
            //todo - solve the waring
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false);
            }
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          )),
      tileColor: Colors.green,
    );
  }

  //M E T H O D for show full name in app

  String get fullName {
    return '${AuthController.user?.firstName ?? ''} ${AuthController.user?.lastName ?? ''}';
  }
}
