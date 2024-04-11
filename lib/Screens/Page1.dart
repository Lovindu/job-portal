import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/Page3.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 800,
        color: Colors.deepPurpleAccent[200],
        child: Column(
          children: [
            const SizedBox(
              height: 0,
            ),
            Image.asset("lib/Images/testingJob.png"),
            const SizedBox(
              height: 30,
            ),
            const Column(
              children: [
                Text(
                  "Find your Dream Job",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "We help to find you a dream job ...",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Stable yourself\nWith your ability",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.to(() => PageThree());
                        },
                        child: const Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
