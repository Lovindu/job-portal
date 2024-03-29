import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurpleAccent[700],
        child: Column(
          children: [
            const SizedBox(
              height: 65,
            ),
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Image.asset("lib/Images/jobstest.jpeg"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stable yourself\nWith your ability",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(padding: EdgeInsets.all(10),
                child: Text("Find your Dream Job",style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
            ),

              ],
            ),
           Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Skip"),
                Text("Next")],),
              ),
            )
          ],
        ),
      ),
    );
  }
}
