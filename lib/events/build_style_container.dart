import 'package:flutter/material.dart';

Widget buildTypeContainer(BuildContext context, Widget child) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("lib/Images/job_back2.jpeg"), fit: BoxFit.cover, opacity: 0.8),
        borderRadius: BorderRadius.all(Radius.circular(10))),
        child: child,
  );
}
