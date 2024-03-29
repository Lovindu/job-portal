import 'package:flutter/material.dart';
import 'package:mobile_application/controllers/jobs_provider.dart';
import 'package:mobile_application/events/jobs_response.dart';
import 'package:mobile_application/events/page_loader.dart';
import 'package:mobile_application/events/popular_job_card.dart';
import 'package:provider/provider.dart';

class PopularJobListCard extends StatelessWidget {
  const PopularJobListCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobs();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<JobsResponse>>(
              future: jobsNotifier.jobList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoader();
                } else if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                } else if (snapshot.data!.isEmpty) {
                  return const Text("No Jobs Available");
                } else {
                  final jobs = snapshot.data;

                  return ListView.builder(
                      itemCount: jobs!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var job = jobs[index];
                        return pJobCard(
                          job: job,
                          text: 'popular',
                        );
                      });
                }
              }),
        );
      },
    );
  }
}
