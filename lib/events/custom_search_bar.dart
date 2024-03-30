import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/route_manager.dart';

class SearchBAR extends StatelessWidget {
  SearchBAR({super.key, this.onTap, required this.controller});

  final TextEditingController controller;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 40,
      padding: EdgeInsets.only(bottom: 5.w),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.chevron_back_outline,
                  color: Colors.white,
                ),
              )),
          Container(
            padding: EdgeInsets.only(top: 20.h),
            width: 260,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.red, width: 0.5)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.5)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.red, width: 0.5)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.zero,
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0.5)),
                  border: InputBorder.none),
              controller: controller,
              cursorHeight: 25,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
          GestureDetector(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Ionicons.search,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
