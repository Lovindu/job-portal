import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_application/Screens/Page3.dart';
import 'package:mobile_application/Screens/SignUp.dart';
import 'package:mobile_application/controllers/login_provide.dart';
import 'package:mobile_application/events/build_style_container.dart';
import 'package:mobile_application/events/customTextField.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/login_model.dart';
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
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      loginNotifier.getPrefs();

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            text: "Login",
            child: loginNotifier.entryPoint && loginNotifier.loggedIn
                ? GestureDetector(
                    onTap: () {
                      Get.offAll(() => const PageThree());
                    },
                    child: Icon(CupertinoIcons.arrow_left_circle),
                  )
                : SizedBox.shrink(),
          ),
        ),
        body: loginNotifier.loader
            ? PageLoader()
            : buildTypeContainer(
                context,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Form(
                    key: loginNotifier.loginFormKey,
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
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
                          obscureText: loginNotifier.obscureText,
                          validator: (password) {
                            if (password!.isEmpty || password.length < 6) {
                              return "Please enter a valid password";
                            } else {
                              return null;
                            }
                          },
                          suffixIcon: GestureDetector(
                            onTap: () {
                              loginNotifier.obscureText =
                                  !loginNotifier.obscureText;
                            },
                            child: Icon(
                              loginNotifier.obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
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
                              Get.offAll(() => const SignUp());
                            },
                            child: const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (loginNotifier.validateAndSave()) {
                              LoginModel model = LoginModel(
                                email: email.text,
                                password: password.text,
                              );
                              loginNotifier.userLogin(model);
                            } else {
                              Get.snackbar(
                                'Sign failed',
                                'Please check your user credentails',
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                                icon: Icon(Icons.add_alarm),
                              );
                            }
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
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      );
    });
  }
}
