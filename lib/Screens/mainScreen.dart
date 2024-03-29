import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:mobile_application/Main_Screens/applied_jobs.dart';
import 'package:mobile_application/Main_Screens/bookmark.dart';
import 'package:mobile_application/Main_Screens/chat_page.dart';
import 'package:mobile_application/Main_Screens/home_page.dart';
import 'package:mobile_application/Main_Screens/profilr_page.dart';
import 'package:mobile_application/controllers/zoom_provider.dart';
import 'package:mobile_application/events/drawer_screen.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ZoomNotifier>(builder: (context, zoomNotifier, child) {
      return ZoomDrawer(
      menuScreen: DrawerScreen(indexSetter: (index) {
        zoomNotifier.currentIndex = index;
      }),
      mainScreen: currentScreen(),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      slideWidth: 250,
      menuBackgroundColor: Colors.black,
    );
    });
  }

  Widget currentScreen() {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    switch (zoomNotifier.currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const ChatPage();
      case 2:
        return const BookMark();
      case 3:
        return const AppliedJob();
      case 4:
        return const ProfilePage(
          drawer: true,
        );
      default:
        return const HomePage();
    }
  }
}


