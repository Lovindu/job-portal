import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/drawer_widget.dart';

class AppliedJob extends StatefulWidget {
  const AppliedJob({super.key});

  @override
  State<AppliedJob> createState() => _AppliedJobState();
}

class _AppliedJobState extends State<AppliedJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          
          child: Padding(
            padding:  EdgeInsets.all(8.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Center(
        child: Text("Applied Jobs"),
      ),
    );
  }
}