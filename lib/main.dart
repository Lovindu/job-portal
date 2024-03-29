
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/loading.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/controllers/jobs_provider.dart';
import 'package:mobile_application/controllers/login_provide.dart';
import 'package:mobile_application/controllers/signup_provider.dart';
import 'package:mobile_application/controllers/zoom_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
      ChangeNotifierProvider(create: (context) => SignUpNotifier()),
      ChangeNotifierProvider(create: (context) => ZoomNotifier()),
      ChangeNotifierProvider(create: (context) => JobsNotifier()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Poppins',
            scaffoldBackgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            primarySwatch: Colors.grey,
          ),
          home: LoadingScreen(),
        );
      },
    );
  }
}
