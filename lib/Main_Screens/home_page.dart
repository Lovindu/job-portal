import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Main_Screens/profilr_page.dart';
import 'package:mobile_application/Screens/popular_job_view.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/drawer_widget.dart';
import 'package:mobile_application/events/head_widget.dart';
import 'package:mobile_application/events/popular_jobs.dart';
import 'package:mobile_application/events/recent_jobs.dart';
import 'package:mobile_application/events/search_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => ProfilePage(drawer: false));
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundImage:
                        AssetImage("lib/Images/icons8-user-50.png"),
                  ),
                ),
              ),
            ],
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: DrawerWidget(),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search your\n dream job",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SearchBarr(
                  onTap: () {},
                ),
                SizedBox(
                  height: 20.h,
                ),
                Heading(
                  text: "Popular Jobs",
                  onTap: () {
                    Get.to(() => PopularView());
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                PopularJobs(),
                SizedBox(
                  height: 20.h,
                ),
                Heading(
                  text: "Recent Jobs",
                ),
                SizedBox(
                  height: 10.h,
                ),
                RecentJobs(),
              ],
            ),
          ),
        )));
  }
}
