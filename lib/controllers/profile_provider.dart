import 'package:flutter/material.dart';
import 'package:mobile_application/Services/auth_help.dart';
import 'package:mobile_application/events/profilr_res.dart';

class ProfileNotifier extends ChangeNotifier {
  Future<ProfileRes>? profile;
  getProfile() async {
    profile = AuthHelper.getProfile();
  }
}
