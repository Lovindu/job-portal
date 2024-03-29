import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/events/back_button_profile.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/drawer_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          child: Padding(
            padding: EdgeInsets.all(8.0.h),
            child: widget.drawer == false? BackProfile():DrawerWidget(),
          ),
        ),
      ),
      body: Center(
        child: Text("Profile"),
      ),
    );
  }
}
