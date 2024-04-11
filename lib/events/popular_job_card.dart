import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/job_details.dart';
import 'package:mobile_application/events/jobs_response.dart';

class pJobCard extends StatelessWidget {
  const pJobCard({super.key, required this.job, required this.text});

  final JobsResponse job;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Get.to(() => JobDetails(
              title: job.title, id: job.id, agentName: job.agentName));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
            height: 85,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.brown),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              job.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              job.company,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        /*text == 'popular'
                            ? CustomButton(
                                width: 70.w,
                                height: 30.h,
                                color: Colors.white,
                                text: "View")
                            : CustomButton(
                                width: 90.w,
                                height: 30.h,
                                text: "Apply",
                                color: Colors.white)*/
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
