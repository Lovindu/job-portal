import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/Services/chat_helper.dart';
import 'package:mobile_application/Services/message_helper.dart';
import 'package:mobile_application/controllers/jobs_provider.dart';
import 'package:mobile_application/events/back_button_profile.dart';
import 'package:mobile_application/events/build_style_container.dart';
import 'package:mobile_application/events/create_chat.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/custom_button.dart';
import 'package:mobile_application/events/get_job.dart';
import 'package:mobile_application/events/page_loader.dart';
import 'package:mobile_application/events/send_message.dart';
import 'package:provider/provider.dart';

class JobDetails extends StatefulWidget {
  const JobDetails(
      {super.key,
      required this.title,
      required this.id,
      required this.agentName});

  final String title;
  final String id;
  final String agentName;

  @override
  State<JobDetails> createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobsNotifier, child) {
      jobsNotifier.getJob(widget.id);
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
                text: "Job Details",
                actions: [
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                    ),
                  )
                ],
                child: const BackProfile())),
        body: buildTypeContainer(
          context,
          FutureBuilder<GetJobRes>(
              future: jobsNotifier.job,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoader();
                } else if (snapshot.hasError) {
                  return Text("Error : ${snapshot.error}");
                } else {
                  final job = snapshot.data;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 100,
                              height: 270,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        "lib/Images/jobs_back.jpeg",
                                      ),
                                      opacity: 0.5,
                                      fit: BoxFit.fill)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(job!.imageUrl),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    job.title,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    job.location,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.brown),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                            height: 40,
                                            width: 100,
                                            text: job.contract,
                                            color: Colors.black),
                                        Row(
                                          children: [
                                            Text(
                                              job.salary,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.brown),
                                            ),
                                            Text(
                                              "/${job.period}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.brown),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              job.description,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Requirements',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 300,
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: job.requirements.length,
                                  itemBuilder: (context, index) {
                                    var requirement = job.requirements[index];
                                    String bullet = '\u2022';
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 12),
                                      child: Text(
                                        "$bullet $requirement",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20.0.w),
                            child: GestureDetector(
                              onTap: () {
                                CreateChat model =
                                    CreateChat(userId: job.agentId);
                                ChatHelper.apply(model).then((response) {
                                  if (response[0]) {
                                    SendMessage model = SendMessage(
                                        content:
                                            "Hello i'm interested ${job.title}",
                                        chatId: response[1],
                                        receiver: job.agentId);
                                    MesssagingHelper.sendMessage(model)
                                        .whenComplete(() {
                                      Get.to(() => MainScreen());
                                    });
                                  }
                                });
                              },
                              child: const CustomButton(
                                text: "Apply Now",
                                color: Colors.black,
                                color2: Colors.grey,
                                height: 50,
                                width: 300,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }),
        ),
      );
    });
  }
}
