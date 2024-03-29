import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/Screens/Page1.dart';
import 'package:mobile_application/Screens/Page2.dart';
import 'package:mobile_application/Screens/Page3.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            PreferredSize(preferredSize: Size.fromHeight(50.h), child: AppBar()),
        body: Stack(
          children: [
            PageView(
              children: const [
                PageOne(),
                PageTwo(),
                PageThree(),
              ],
            )
          ],
        ));
  }
}
