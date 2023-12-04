import 'package:flutter/material.dart';
import 'package:task_mp/data/models/user_model.dart';
import 'package:task_mp/data/network_caller/network_caller.dart';
import 'package:task_mp/data/network_caller/network_response.dart';
import 'package:task_mp/data/utility/urls.dart';
import 'package:task_mp/ui/controllers/auth_controller.dart';
import 'package:task_mp/ui/screens/forgot_password_screen.dart';
import 'package:task_mp/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_mp/ui/screens/sign_up_screen.dart';
import 'package:task_mp/ui/widget/body_background.dart';
import 'package:task_mp/ui/widget/snack_message.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _loginInProgress = false;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Text("Get started with",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    //TextField For Email
                    TextFormField(
                      controller: _emailTEController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Email",
                      ),
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "enter a email";
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
                      validator: (String? value) {
                        if (value?.isEmpty ?? true) {
                          return "enter a password";
                        } else {
                          return null;
                        }
                      },
                    ),

                    const SizedBox(height: 16),
                    //Elevated Button
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _loginInProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await _loginIn();
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordScreen(),
                              ));
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black54),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            'Sign Up',
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

  //User Login using _L O G I N  M E T H O D

  Future<void> _loginIn() async {
    if (mounted) {
      setState(() {
        _loginInProgress = true;
      });
    }
    // NetworkCaller networkCaller = NetworkCaller();
    final NetworkResponse response =
        await NetworkCaller().postRequest(Urls.login,
            body: {
              "email": _emailTEController.text.trim(),
              "password": _passwordTEController.text,
            },
            isLogin: true);
    if (mounted) {
      setState(() {
        _loginInProgress = false;
      });
    }
    //we can use 'response.isSuccess' insted of 'response.statusCode == 200'
    if (response.isSuccess) {
      await AuthController.saveUserInformation(response.jsonResponse['token'],
          UserModel.fromJson(response.jsonResponse['data']));
      if (mounted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavScreen()));
      }
    } else {
      if (response.statusCode == 401) {
        if (mounted) {
          showSnackMessage(context, 'Please check email and password');
        } else {
          if (mounted) {
            showSnackMessage(context, 'Login failed! please try again');
          }
        }
      }
      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Center(child: Text('Enter a valid cridential'))));
      // }
    }

    // log(response.statusCode.toString());
    // log(response.jsonResponse.toString());
  }

  //dispose method for memory reduce - D I S P O S E  M E T H O D
  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
