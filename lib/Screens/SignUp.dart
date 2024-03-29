import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_application/Screens/Login.dart';
import 'package:mobile_application/controllers/signup_provider.dart';
import 'package:mobile_application/events/customTextField.dart';
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
    return Consumer<SignUpNotifier>(builder: (context, signupNotifier, child) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Hello, Welcome!!!",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
                ),
                const SizedBox(
                  height: 50,
                ),
                 CustomTextField(
                  controller: name,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Full Name",
                  validator: (name) {
                    if (name!.isEmpty) {
                      return "Please your Full Name";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20,),
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
                    if (signupNotifier.passwordValidator(password ?? '')) {
                      return "Plase Enter a valid password with at least one uppercase letter, one lowercase, one digit, a special character and length of 8 characters";
                    }
                    return null;
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      signupNotifier.obscureText = !signupNotifier.obscureText;
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
                      Get.to(() => const LoginPage());
                    },
                    child: const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 150,
                    height: 50,
                    color: Colors.orange[900],
                    child: const Center(
                        child: Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
