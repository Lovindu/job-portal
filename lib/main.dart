import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/Login.dart';
import 'package:mobile_application/Screens/loading.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/Screens/personal_details.dart';
import 'package:mobile_application/controllers/image_provider.dart';
import 'package:mobile_application/controllers/jobs_provider.dart';
import 'package:mobile_application/controllers/login_provide.dart';
import 'package:mobile_application/controllers/profile_provider.dart';
import 'package:mobile_application/controllers/signup_provider.dart';
import 'package:mobile_application/controllers/zoom_provider.dart';
import 'package:mobile_application/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget defaultHome = LoadingScreen();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final entrypoint = prefs.getBool('enttrypoint') ?? false;
  final loggedIn = prefs.getBool('loggedIn') ?? false;

  if (entrypoint & !loggedIn) {
    defaultHome = LoginPage();
  } else if (entrypoint && loggedIn) {
    defaultHome = MainScreen();
  }

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => LoginNotifier()),
      ChangeNotifierProvider(create: (context) => SignUpNotifier()),
      ChangeNotifierProvider(create: (context) => ZoomNotifier()),
      ChangeNotifierProvider(create: (context) => JobsNotifier()),
      ChangeNotifierProvider(create: (context) => ImageUploader()),
      ChangeNotifierProvider(create: (context) => ProfileNotifier()),
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
          home: defaultHome,
        );
      },
    );
  }
}
