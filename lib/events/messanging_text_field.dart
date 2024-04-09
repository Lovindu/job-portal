import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingField extends StatelessWidget {
  const MessagingField({
    super.key,
    required this.messageController,
    required this.sufixIcon,
    this.onChanged,
    this.onEditingComplete,
    this.onTapOutside,
    this.onSubmitted,
  });

  final TextEditingController messageController;
  final Widget sufixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageController,
      cursorColor: Colors.black,
      keyboardType: TextInputType.multiline,
      style: TextStyle(
          fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(6.h),
          filled: true,
          fillColor: Colors.black,
          suffixIcon: sufixIcon,
          hintText: "Message...",
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.h),
              ),
              borderSide: BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.h),
              ),
              borderSide: BorderSide(color: Colors.brown))),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
