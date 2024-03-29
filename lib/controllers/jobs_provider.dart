import 'package:flutter/material.dart';
import 'package:mobile_application/Services/job_help.dart';
import 'package:mobile_application/events/get_job.dart';
import 'package:mobile_application/events/jobs_response.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<List<JobsResponse>> recentJobList;
  late Future<GetJobRes> job;

  Future<List<JobsResponse>> getJobs() {
    jobList = JobHelper.getJobs();
    return jobList;
  }

  Future<List<JobsResponse>> getRecent() {
    recentJobList = JobHelper.getRecent();
    return recentJobList;
  }

  Future<GetJobRes> getJob(String jobId) {
    job = JobHelper.getJob(jobId);
    return job;
  }
}
