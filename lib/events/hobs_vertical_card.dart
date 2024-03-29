import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/job_details.dart';
import 'package:mobile_application/events/jobs_response.dart';

class JobsVeticalCard extends StatelessWidget {
  const JobsVeticalCard({super.key, required this.job});

  final JobsResponse job;

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
                borderRadius: BorderRadius.circular(10), color: Colors.black),
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
                            )
                          ],
                        )
                      ],
                    ),
                    const CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      child: Icon(Ionicons.chevron_forward),
                    )
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
