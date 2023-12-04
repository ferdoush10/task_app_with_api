// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:task_mp/ui/controllers/auth_controller.dart';
import 'package:task_mp/ui/widget/body_background.dart';
import 'package:task_mp/ui/widget/profile_summary_card.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  // final TextEditingController _firstNameTEController = TextEditingController();
  // final TextEditingController _lastNameTEController = TextEditingController();
  // final TextEditingController _mobileTEController = TextEditingController();
  // final TextEditingController _passwordTEController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const ProfileSummaryCard(
            enabledOnTap: false,
          ),
          Expanded(
              child: BodyBackground(
            child: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Text("Update Profile",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  photoPickerField(),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Email")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration:
                          const InputDecoration(hintText: "First Name")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Last Name")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Mobile")),
                  const SizedBox(height: 8),
                  TextFormField(
                      decoration: const InputDecoration(hintText: "Password")),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.arrow_circle_right_outlined),
                    ),
                  ),
                ],
              ),
            )),
          )),
        ],
      )),
    );
  }

  Container photoPickerField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(children: [
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              child: const Text(
                'Photo',
                style: TextStyle(color: Colors.white),
              ),
            )),
        Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              child: const Text('Empty'),
            )),
      ]),
    );
  }
}
