import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/job_details.dart';
import 'package:mobile_application/controllers/jobs_provider.dart';
import 'package:mobile_application/events/build_style_container.dart';
import 'package:mobile_application/events/jobs_horizontal_card.dart';
import 'package:mobile_application/events/jobs_response.dart';
import 'package:mobile_application/events/no_search_result.dart';
import 'package:mobile_application/events/page_loader.dart';
import 'package:provider/provider.dart';

class PopularJobs extends StatelessWidget {
  const PopularJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsnotifier, child) {
        jobsnotifier.getJobs();
        return SizedBox(
          height: 200,
          child: FutureBuilder<List<JobsResponse>>(
              future: jobsnotifier.jobList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return const Text("No Jobs Available");
                } else {
                  final jobs = snapshot.data;

                  return ListView.builder(
                      itemCount: jobs!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var job = jobs[index];
                        return JobsHorizontalCard(
                          job: job,
                          onTap: () {
                            Get.to(() =>  JobDetails(id:job.id,title: job.title,agentName: job.agentName,));
                          },
                        );
                      });
                }
              }),
        );
      },
    );
  }
}
