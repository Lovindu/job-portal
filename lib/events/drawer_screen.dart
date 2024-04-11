import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mobile_application/controllers/zoom_provider.dart';
import 'package:provider/provider.dart';

class DrawerScreen extends StatefulWidget {
  final ValueSetter indexSetter;
  const DrawerScreen({super.key, required this.indexSetter});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return GestureDetector(
        onDoubleTap: () {
          ZoomDrawer.of(context)!.toggle();
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              drawerItem(AntDesign.home, "Home", 0,
                  zoomNotifier.currentIndex == 0 ? Colors.brown : Colors.white),
              drawerItem(Ionicons.chatbubble_outline, "Chat", 1,
                  zoomNotifier.currentIndex == 1 ? Colors.brown : Colors.white),
              drawerItem(FontAwesome.user, "Profile", 2,
                  zoomNotifier.currentIndex == 2 ? Colors.brown : Colors.white)
            ],
          ),
        ),
      );
    });
  }

  Widget drawerItem(IconData icon, String text, int index, Color color) {
    return GestureDetector(
      onTap: () {
        widget.indexSetter(index);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20.w, bottom: 20.h),
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(
              width: 12,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: color),
            )
          ],
        ),
      ),
    );
  }
}
