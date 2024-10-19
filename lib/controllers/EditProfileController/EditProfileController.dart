import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restuarant_pager_app/controllers/EmailController/EmailController.dart';
import 'package:restuarant_pager_app/controllers/PhoneNumberController/PhoneNumberController.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/firebase/StorageMethods/StorageMethods.dart';
import 'package:restuarant_pager_app/models/EditProfileModel/EditProfile.model.dart';
import 'package:restuarant_pager_app/utils/imagePicker.dart';

class EditProfileController extends GetxController {
  var model = EditProfileModel().obs;
  final userController = Get.find<UserController>();
  PhoneNumberController phoneNumberController =
      Get.put(PhoneNumberController());
  EmailController emailController = Get.put(EmailController(), permanent: true);
  File? _selectedPic;

  @override
  void onInit() {
    super.onInit();
    emailController.emailAddress = userController.email;
     WidgetsBinding.instance.addPostFrameCallback((_){
        phoneNumberController.phoneNumberModel.update((model) {
            model?.phoneNumber =
                userController.currentUser.value.phone!.phoneNumber;
            model?.countryCode =
                userController.currentUser.value.phone!.countryCode;
        });
     });
    
    model.update((model) {
      model?.dateOfBirth = userController.dateOfBirth;
      model?.name = userController.name;
      model?.gender = userController.gender;
      model?.profilePic = userController.profilePic;
      // model?.email = userController.email;
      model?.phoneNumber = userController.currentUser.value.phone;
    });
  }


  // Getters
  String? get profilePic => model.value.profilePic;
  File? get selectedPic => _selectedPic;
  String? get gender => model.value.gender;
  String? get dateOfBirth => model.value.dateOfBirth;
  String? get name => model.value.name;
  // String? get emailAddress => model.value.email;
  // String? get phoneNumber => model.value.phoneNumber?.phoneNumber;
  // String? get countryCode => model.value.phoneNumber!.countryCode;
  String? get emailAddress => emailController.emailAddress;
  String? get phoneNumber => phoneNumberController.phoneNumber;
  String? get countryCode => phoneNumberController.selectedCountryCode;

  String? get countryFlag {
    final selectedCode = countryCode;
    final country = phoneNumberController.countries.firstWhere(
      (country) => country['code'] == selectedCode,
      orElse: () => {},
    );
    return country['icon'];
  }

  Future<void> selectImage() async {
    final file = await pickImage(ImageSource.gallery);
    _selectedPic = file;
  }

  void submit() async {
    final authMethods = Get.find<AuthMethods>();
    // upload profile pic if given
    String? downloadUrl;
    if (_selectedPic != null) {
      final res = await StorageMethods().uploadProfilePic(file: _selectedPic!);
      if (res.message == "success") {
        downloadUrl = res.data;
      } else {
        if (kDebugMode) debugPrint("error uploading file : ${res.message}");
      }
    }
    // update model
    model.update((model) {
      model?.profilePic = downloadUrl ?? profilePic;
      model?.email = emailController.emailAddress;
      model?.phoneNumber = phoneNumberController.phoneNumberModel.value;
    });

    userController.updateUserDetails(
        name: name,
        dateOfBirth: dateOfBirth,
        profilePic: profilePic,
        gender: gender,
        phone: phoneNumberController.phoneNumberModel.value,
        email: emailController.emailAddress);
    final res = await authMethods.updateUser(userController.user);
    if (res.message != "success") {
      if (kDebugMode) debugPrint("error updating details : ${res.message}");
    }
  }

  String? validateName() {
    if (model.value.name == null || model.value.name!.isEmpty) {
      return "Name can't be empty";
    }
    return null;
  }

  String? validateDOB() {
    if (model.value.dateOfBirth == null || model.value.dateOfBirth!.isEmpty) {
      return "Please Mention Your DOB";
    }
    return null;
  }

  void updateName(String name) {
    model.update((model) {
      model?.name = name;
    });
  }

  Future<void> selectDateOfBirth(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(1900);
    DateTime lastDate = DateTime(2100);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null && picked != initialDate) {
      model.update((model) {
        model?.dateOfBirth = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  String? validatePhoneNumber() {
    return phoneNumberController.validate();
  }

  String? validateEmail() {
    if (!emailController.validate()) {
      return "Invalid Email address";
    }
    return null;
  }

  void clearDateOfBirth() {
    model.value.dateOfBirth = null;
  }

  void updateGender(String? gender) {
    model.update((model) {
      model?.gender = gender;
    });
  }

  void updateEmail(String email) {
    emailController.updateEmailAddress(email);
  }
}
