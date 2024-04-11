import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/convo_page.dart';
import 'package:mobile_application/Screens/loader.dart';
import 'package:mobile_application/controllers/chat_provider.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/drawer_widget.dart';
import 'package:mobile_application/events/get_chat.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: "Chats",
            child: Padding(
              padding: EdgeInsets.all(8.0.h),
              child: DrawerWidget(),
            ),
          ),
        ),
        body: Consumer<ChatNotifier>(
          builder: (context, chatNotifier, child) {
            chatNotifier.getChats();
            chatNotifier.getPrefs();
            return FutureBuilder<List<GetChats>>(
                future: chatNotifier.chats,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "Error${snapshot.error}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.red),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return const SearchLoading(
                      text: "No chats available",
                    );
                  } else {
                    final chats = snapshot.data;
                    return ListView.builder(
                        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
                        itemCount: chats!.length,
                        itemBuilder: (context, index) {
                          final chat = chats[index];
                          var user = chat.users
                              .where((user) => user.id != chatNotifier.userId);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => CoversationPage(
                                      id: chat.id,
                                      title: user.first.username,
                                      profile: user.first.profile,
                                      user: [
                                        chat.users[0].id,
                                        chat.users[1].id
                                      ],
                                    ));
                              },
                              child: Container(
                                height: 100,
                                width: 300,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  minLeadingWidth: 0,
                                  minVerticalPadding: 0,
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(user.first.profile),
                                  ),
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.first.username,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        chat.latestMessage.content,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  trailing: Padding(
                                    padding:
                                        EdgeInsets.only(top: 0, right: 5.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            chatNotifier.msgTime(
                                                chat.updatedAt.toString()),
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.normal)),
                                        Icon(
                                          chat.chatName == chatNotifier.userId
                                              ? Ionicons.arrow_forward_circle
                                              : Ionicons.arrow_back_circle,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  }
                });
          },
        ));
  }
}
