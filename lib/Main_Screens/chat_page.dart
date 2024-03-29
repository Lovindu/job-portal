import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/drawer_widget.dart';

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
          child: Padding(
            padding:  EdgeInsets.all(8.0.h),
            child: DrawerWidget(),
          ),
        ),
      ),
      body: Center(
        child: Text("Chat Page"),
      ),
    );
  }
}