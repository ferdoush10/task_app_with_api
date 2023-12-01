import 'package:flutter/material.dart';
import 'package:task_mp/data/network_caller/network_caller.dart';
import 'package:task_mp/data/network_caller/network_response.dart';
import 'package:task_mp/data/utility/urls.dart';
import 'package:task_mp/ui/widget/body_background.dart';
import 'package:task_mp/ui/widget/snack_message.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _signUpInProgress = false;

  //Registration using signUp method

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      _signUpInProgress = true;
      if (mounted) {
        setState(() {});
      }
      final NetworkResponse reponse =
          await NetworkCaller().postRequest(Urls.registration, body: {
        "email": _emailTEController.text.trim(),
        "firstName": _firstNameTEController.text.trim(),
        "lastName": _lastNameTEController.text.trim(),
        "mobile": _mobileTEController.text.trim(),
        "password": _passwordTEController.text.trim(),
        "photo": "",
      });
      _signUpInProgress = false;
      if (mounted) {
        setState(() {});
      }
      if (reponse.isSuccess) {
        _clearTextFields();
        if (mounted) {
          showSnackMessage(context, "Account has been created! Please login.");
        }
      } else {
        if (mounted) {
          showSnackMessage(
              context, 'Account creation failed! please try again');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text("Join With Us",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    //TextField For Email
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      //todo- validate email address using regex
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
                    const SizedBox(height: 16),
                    //TextField For First Name
                    TextFormField(
                      controller: _firstNameTEController,
                      decoration: const InputDecoration(
                        hintText: "First Name",
                      ),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return "Enter your first name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    //TextField For Last Name
                    TextFormField(
                      controller: _lastNameTEController,
                      decoration: const InputDecoration(
                        hintText: "Last Name",
                      ),
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return "Enter your last name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    //TextField For Mobile
                    TextFormField(
                      controller: _mobileTEController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: "Mobile",
                      ),
                      //todo- validate the mobile number with 11 digit
                      validator: (String? value) {
                        if (value!.trim().isEmpty) {
                          return " enter mobile number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    //TextField For Password
                    TextFormField(
                      controller: _passwordTEController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Password",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "enter a password";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    //Elevated Button
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _signUpInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              _signUp();
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                    const SizedBox(height: 48),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _clearTextFields() {
    _emailTEController.clear();
    _firstNameTEController.clear();
    _lastNameTEController.clear();
    _mobileTEController.clear();
    _passwordTEController.clear();
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();

    super.dispose();
  }
}
