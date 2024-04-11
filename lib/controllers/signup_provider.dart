import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/Screens/Login.dart';
import 'package:mobile_application/Services/auth_help.dart';
import 'package:mobile_application/events/signup_model.dart';

class SignUpNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

  bool _loader = false;

  bool get loader => _loader;
  set loader(bool newState) {
    _loader = newState;
    notifyListeners();
  }

  bool passwordValidator(String password) {
    if (password.isEmpty) return false;
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password);
  }

  final signupFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = signupFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  upSignUp(SignupModel model) {
    AuthHelper.signup(model).then((response) {
      if (response) {
        Get.off(() => LoginPage(),
            transition: Transition.fade, duration: Duration(seconds: 2));
      } else {
        Get.snackbar('Sign up failed', 'Please check your user credentails',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.add_alarm));
      }
    });
  }
}
