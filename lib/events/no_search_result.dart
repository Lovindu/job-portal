import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoSearchResult extends StatelessWidget {
  const NoSearchResult({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Opacity(
              opacity: 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "lib/Images/seaching_bar.jpeg",
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
