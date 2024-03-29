import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/events/back_button_profile.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/popular_job_list_card.dart';

class PopularView extends StatelessWidget {
  const PopularView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.w),
          child: CustomAppBar(
            text: "Popular Jobs",
            child: BackProfile(),
          )),
      body: PopularJobListCard(),
    );
  }
}
