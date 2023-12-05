import 'package:flutter/material.dart';

import 'package:task_mp/data/models/user_model.dart';
import 'package:task_mp/data/network_caller/network_caller.dart';
import 'package:task_mp/data/network_caller/network_response.dart';
import 'package:task_mp/data/utility/urls.dart';
import 'package:task_mp/ui/controllers/auth_controller.dart';
import 'package:task_mp/ui/widget/body_background.dart';
import 'package:task_mp/ui/widget/profile_summary_card.dart';
import 'package:task_mp/ui/widget/snack_message.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProfileInProgress = false;
  // XFile? photo;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.user?.email ?? '';
    _firstNameTEController.text = AuthController.user?.firstName ?? '';
    _lastNameTEController.text = AuthController.user?.lastName ?? '';
    _mobileTEController.text = AuthController.user?.mobile ?? '';
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
              child: Form(
                key: _formKey,
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
                      controller: _emailTEController,
                      decoration: const InputDecoration(hintText: "Email"),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,3}')
                                .hasMatch(value)) {
                          return "Enter correct email";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(hintText: "First Name"),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return "Enter your first name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(hintText: "Last Name"),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _mobileTEController,
                      decoration: const InputDecoration(hintText: "Mobile"),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return " enter mobile number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passwordTEController,
                      decoration: const InputDecoration(hintText: "Password"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter a password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _updateProfileInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              profileUpdate();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
          )),
        ],
      )),
    );
  }

  Future<void> profileUpdate() async {
    _updateProfileInProgress = true;
    if (mounted) {
      setState(() {});
    }
    Map<String, dynamic> inputData = {
      "email": _emailTEController.text.trim(),
      "firstName": _firstNameTEController.text.trim(),
      "lastName": _lastNameTEController.text.trim(),
      "mobile": _mobileTEController.text.trim(),
    };
    if (_passwordTEController.text.isNotEmpty) {
      inputData['password'] = _passwordTEController.text;
    }
    // if (photo != null) {
    //   List<int> imageBytes = await photo!.readAsBytes();
    //   String photoInBase64 = base64Encode(imageBytes);
    //   inputData['photo'] = photoInBase64;
    // }
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.updateProfile, body: inputData);
    _updateProfileInProgress = false;
    if (mounted) {
      setState(() {});
    }
    if (response.isSuccess) {
      AuthController.updateUserInformation(UserModel(
        email: _emailTEController.text.trim(),
        firstName: _firstNameTEController.text.trim(),
        lastName: _lastNameTEController.text.trim(),
        mobile: _mobileTEController.text.trim(),
      ));
      if (mounted) {
        showSnackMessage(context, 'Profile update success');
      }
    } else {
      if (mounted) {
        showSnackMessage(context, 'Profile update failed.try again.');
      }
    }
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

          // final XFile? image = await ImagePicker()
          //     .pickImage(source: ImageSource.gallery, imageQuality: 50);
          // if (image != null) {
          //   photo = image;
          //   if (mounted) {
          //     setState(() {});
          //   }
          // }

          child: Container(
            padding: const EdgeInsets.only(left: 16),
            child: const Text('Select a photo'),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
  }
}
