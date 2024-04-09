import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_application/Screens/Login.dart';
import 'package:mobile_application/Screens/Page3.dart';
import 'package:mobile_application/controllers/login_provide.dart';
import 'package:mobile_application/controllers/signup_provider.dart';
import 'package:mobile_application/controllers/zoom_provider.dart';
import 'package:mobile_application/events/build_style_container.dart';
import 'package:mobile_application/events/customTextField.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/page_loader.dart';
import 'package:mobile_application/events/signup_model.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignUpNotifier>(builder: (context, signupNotifier, child) {
      return Scaffold(
          appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBar(
            text: "Sign up",
            child:  GestureDetector(
                    onTap: () {
                       Get.offAll(() => const PageThree());
                    },
                    child: Icon(CupertinoIcons.arrow_left_circle),
                  )
          ),
        ),
          body: signupNotifier.loader
              ? PageLoader()
              : buildTypeContainer(
                  context,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: signupNotifier.signupFormKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            "Hello, Welcome to",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 30),
                          ),
                          Text(
                            "JobSL!!!",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 45),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          CustomTextField(
                            controller: name,
                            keyboardType: TextInputType.text,
                            hintText: "Full Name",
                            validator: (name) {
                              if (name!.isEmpty) {
                                return "Please your Full Name";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
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
                            obscureText: signupNotifier.obscureText,
                            validator: (password) {
                              if (password!.isEmpty || password.length < 8) {
                                return "Plase Enter a valid password with at least one uppercase letter, one lowercase, one digit, a special character and length of 8 characters";
                              }
                              return null;
                            },
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signupNotifier.obscureText =
                                    !signupNotifier.obscureText;
                              },
                              child: Icon(
                                signupNotifier.obscureText
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
                                Get.offAll(() => const LoginPage());
                              },
                              child: const Text(
                                "Have an account",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          GestureDetector(
                            onTap: () {
                              loginNotifier.firstTime =
                                  !loginNotifier.firstTime;
                              if (signupNotifier.validateAndSave()) {
                                SignupModel model = SignupModel(
                                    username: name.text,
                                    email: email.text,
                                    password: password.text);
                                signupNotifier.upSignUp(model);
                              } else {
                                Get.snackbar('Sign up failed',
                                    'Please check your user credentails',
                                    colorText: Colors.white,
                                    backgroundColor: Colors.red,
                                    icon: Icon(Icons.add_alarm));
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
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
    });
  }
}
