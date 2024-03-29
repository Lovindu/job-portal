import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/drawer_widget.dart';

class BookMark extends StatefulWidget {
  const BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
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
        child: Text("Book mark"),
      ),
    );
  }
}