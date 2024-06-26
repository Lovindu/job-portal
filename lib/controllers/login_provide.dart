import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/mainScreen.dart';
import 'package:mobile_application/Screens/personal_details.dart';
import 'package:mobile_application/Services/auth_help.dart';
import 'package:mobile_application/events/login_model.dart';
import 'package:mobile_application/events/profile_update_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _firstTime = true;

  bool get firstTime => _firstTime;
  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;
  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  bool? _entrypoint;

  bool get entryPoint => _entrypoint ?? false;
  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }

  bool? _loggedIn;

  bool get loggedIn => _loggedIn ?? false;
  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    entrypoint = prefs.getBool('entrypoint') ?? false;
    loggedIn = prefs.getBool('loggedIn') ?? false;
  }

  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profilrValidation() {
    final form = profileFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  userLogin(LoginModel model) {
    AuthHelper.login(model).then((response) {
      if (response && firstTime) {
        Get.off(() => const PersonalDetails());
      } else if (response && !firstTime) {
        Get.off(() => const MainScreen());
      } else if (!response) {
        Get.snackbar('Sign failed', 'Please check your user credentails',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_alarm));
      }
    });
  }

  logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
    firstTime = false;
  }

  updateProfile(ProfileUpdateReq model) async {
    AuthHelper.updateProfile(model).then((response) {
      if (response) {
        Get.snackbar("Profile Update", "Enjoy your search for a job",
            colorText: Colors.white,
            backgroundColor: Colors.blue,
            icon: const Icon(Icons.add_alert));

        Future.delayed(const Duration(seconds: 3)).then((value) {
          Get.offAll(() => const MainScreen());
        });
      } else {
        Get.snackbar("Updating Failed", "Please try again",
            colorText: Colors.white,
            backgroundColor: Colors.orange,
            icon: const Icon(Icons.add_alert));
      }
    });
  }
  }

