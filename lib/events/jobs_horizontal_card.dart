import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:mobile_application/events/jobs_response.dart';

class JobsHorizontalCard extends StatelessWidget {
  const JobsHorizontalCard({super.key, this.onTap, required this.job});

  final void Function()? onTap;
  final JobsResponse job;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8.w),
          ),
          child: Container(
            height: 200,
            width: 300,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                    image: AssetImage("lib/Images/jobstest.jpeg"),
                    fit: BoxFit.contain,
                    opacity: 0.4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(job.imageUrl),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 160.w,
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.w))),
                      child: Text(
                        job.company,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  job.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  job.location,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      job.salary,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "/${job.period}",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: Icon(Ionicons.chevron_forward),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
