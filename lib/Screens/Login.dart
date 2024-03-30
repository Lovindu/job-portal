import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_application/Screens/SignUp.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/controllers/login_provide.dart';
import 'package:mobile_application/controllers/zoom_provider.dart';
import 'package:mobile_application/events/build_style_container.dart';
import 'package:mobile_application/events/customTextField.dart';
import 'package:mobile_application/events/custom_button.dart';
import 'package:mobile_application/events/page_loader.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, logonNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          body: logonNotifier.loader ? PageLoader(): buildTypeContainer(
            context, Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    hintText: "Email",
                    validator: (email) {
                      if (email!.isEmpty || !email.contains("@")) {
                        return "Please enter a valid Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: password,
                    keyboardType: TextInputType.text,
                    hintText: "Password",
                    obscureText: logonNotifier.obscureText,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return "Please enter a valid password";
                      } else {
                        return null;
                      }
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        logonNotifier.obscureText = !logonNotifier.obscureText;
                      },
                      child: Icon(
                        logonNotifier.obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => const SignUp());
                      },
                      child: const Text(
                        "Don't have an account?",
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Consumer<ZoomNotifier>(
                    builder: (context, zoomNotifier, child) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => const MainScreen());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black,
                          ),
                          width: 150,
                          height: 50,
                          child: const Center(
                              child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ));
    });
  }
}
