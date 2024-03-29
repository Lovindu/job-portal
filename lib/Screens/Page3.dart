import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/Login.dart';
import 'package:mobile_application/Screens/SignUp.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/events/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[400],
        child: Column(
          children: [
            Image.asset("lib/Images/jobtest2.png"),
            const SizedBox(
              height: 0,
            ),
            const Text(
              "Welcome to JobSL",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onTap: () async {
                    //final SharedPreferences prefs =
                    //await SharedPreferences.getInstance();

                    // await prefs.setBool('entrypoint', true);
                    Get.to(() => const LoginPage());
                  },
                  text: "Login",
                  width: 150,
                  height: 50,
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUp());
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                    child: const Center(
                        child: Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => const MainScreen());
                },
                child: const Text("Continue as a Guest"))
          ],
        ),
      ),
    );
  }
}
