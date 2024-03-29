import 'package:flutter/material.dart';
import 'package:mobile_application/controllers/jobs_provider.dart';
import 'package:mobile_application/events/hobs_vertical_card.dart';
import 'package:mobile_application/events/jobs_response.dart';
import 'package:provider/provider.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsnotifier, child) {
        jobsnotifier.getRecent();
        return SizedBox(
          height: 200,
          child: FutureBuilder<List<JobsResponse>>(
              future: jobsnotifier.recentJobList,
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
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var job = jobs[index];
                        return JobsVeticalCard(job: job,);
                      });
                }
              }),
        );
      },
    );
  }
}
