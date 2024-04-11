import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:mobile_application/controllers/image_provider.dart';
import 'package:mobile_application/controllers/login_provide.dart';
import 'package:mobile_application/events/customTextField.dart';
import 'package:mobile_application/events/custom_appBar.dart';
import 'package:mobile_application/events/custom_button.dart';
import 'package:mobile_application/events/profile_update_model.dart';
import 'package:provider/provider.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({
    super.key,
  });

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController(text: profile[0]);
  TextEditingController skill1 = TextEditingController(text: profile[1]);
  TextEditingController skill2 = TextEditingController(text: profile[2]);
  TextEditingController skill3 = TextEditingController(text: profile[3]);
  TextEditingController skill4 = TextEditingController(text: profile[4]);

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            text: "Edit Profile",
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(CupertinoIcons.arrow_left_circle),
            )),
      ),
      body: Consumer<LoginNotifier>(
        builder: (context, loginNotifier, child) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Personal Details",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Consumer<ImageUploader>(
                      builder: (context, imageUploader, child) {
                    return imageUploader.imageFil.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              imageUploader.pickImage();
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.blue,
                              //backgroundImage: ,
                              child: Center(
                                child: Icon(Icons.photo_filter),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              imageUploader.imageFil.clear();
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              backgroundImage:
                                  FileImage(File(imageUploader.imageFil[0])),
                            ),
                          );
                  })
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: location,
                    hintText: "Location",
                    keyboardType: TextInputType.text,
                    validator: (location) {
                      if (location!.isEmpty) {
                        return "Please enter your location";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: phone,
                    hintText: "Phone Number",
                    keyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone!.isEmpty) {
                        return "Please enter your phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Professional Skills",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: skill0,
                    hintText: "Professional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill0) {
                      if (skill0!.isEmpty) {
                        return "Please enter your skills";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: skill1,
                    hintText: "Professional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill1) {
                      if (skill1!.isEmpty) {
                        return "Please enter your skills";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: skill2,
                    hintText: "Professional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill2) {
                      if (skill2!.isEmpty) {
                        return "Please enter your skills";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: skill3,
                    hintText: "Professional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill3) {
                      if (skill3!.isEmpty) {
                        return "Please enter your skills";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: skill4,
                    hintText: "Professional Skills",
                    keyboardType: TextInputType.text,
                    validator: (skill4) {
                      if (skill4!.isEmpty) {
                        return "Please enter your skills";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Consumer<ImageUploader>(
                      builder: (context, imageUploader, child) {
                    return CustomButton(
                        onTap: () {
                          if (imageUploader.imageFil.isEmpty &&
                              imageUploader.imageUrl == null) {
                            Get.snackbar(
                              'Image missing',
                              'Please upload an image',
                              colorText: Colors.white,
                              backgroundColor: Colors.orange,
                              icon: const Icon(Icons.add_alert),
                            );
                          } else {
                            ProfileUpdateReq model = ProfileUpdateReq(
                                location: location.text,
                                phone: phone.text,
                                profile: imageUploader.imageUrl.toString(),
                                skills: [
                                  skill0.text,
                                  skill1.text,
                                  skill2.text,
                                  skill3.text,
                                  skill4.text,
                                ]);
                            loginNotifier.updateProfile(model);
                          }
                        },
                        height: 50,
                        text: "Update Profile",
                        color: Colors.black);
                  })
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}

List<String> profile = [];
