import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/Services/job_help.dart';
import 'package:mobile_application/events/custom_search_bar.dart';
import 'package:mobile_application/events/hobs_vertical_card.dart';
import 'package:mobile_application/events/jobs_response.dart';
import 'package:mobile_application/events/no_search_result.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SearchBAR(
            controller: controller,
            onTap: () {
              setState(() {});
            },
          ),
        ),
      ),
      body: controller.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
              child: FutureBuilder<List<JobsResponse>>(
                  future: JobHelper.search(controller.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error : ${snapshot.error}");
                    } else if (snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text(
                        "No Jobs Available 😕",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ));
                    } else {
                      final jobs = snapshot.data;

                      return ListView.builder(
                          itemCount: jobs!.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            var job = jobs[index];
                            return JobsVeticalCard(
                              job: job,
                            );
                          });
                    }
                  }),
            )
          : const NoSearchResult(text: 'Start Searching . . . 🔍'),
    );
  }
}
