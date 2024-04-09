import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('lib/Images/seaching_bar.jpeg'),
          Text(text,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
          ),
        ],
      ),
    );
  }
}