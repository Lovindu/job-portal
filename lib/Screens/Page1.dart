import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.purple[100],
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Image.asset("lib/Images/testingJob.png"),
            const SizedBox(
              height: 40,
            ),
            const Column(
              children: [
                Text(
                  "Find your Dream Job",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We help to find hyou a dream job ...",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Skip"), Text("Next")],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
