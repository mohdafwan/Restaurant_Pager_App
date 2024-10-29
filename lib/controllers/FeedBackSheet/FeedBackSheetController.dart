import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/models/FeedBack/FeedBack.model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:restuarant_pager_app/utils/toastMessage.dart';

class FeedBackSheetController extends GetxController {
  final model = Get.put(FeedBackModel()).obs;
  final userController = Get.find<UserController>();
  dio.Dio _dio = dio.Dio(); 
  final RxInt _pageIndex = 0.obs;
  final RxInt _counter = 0.obs;


  @override
  void onClose() {
    Get.delete<FeedBackModel>();
    super.onClose();
  }

  @override
  onInit(){
    model.value.name = userController.name;
    model.value.email = userController.email;
    super.onInit();
  }
  String? get name => model.value.name;
  String? get email => model.value.email;
  String? get about => model.value.about;
  String? get issue => model.value.issue;
  String? get message => model.value.message;
  int get pageIndex => _pageIndex.value;
  int get counter => _counter.value;
  set pageIndex(int index) {
    _pageIndex.value = index;
  }
  set message(String? text){
    model.value.message = text;
  }
  set counter(int count){
    _counter.value = count;
  }
  set about(String? txt){
    model.value.about = txt;
  }
   set issue(String? txt){
    model.value.issue = txt;
  }

  void updateName(String name) {
    model.value.name = name;
  }
  void updateEmail(String email) {
    model.value.email = email;
  }

  String? validateName() {
    if (model.value.name == null || model.value.name!.isEmpty) {
      return "Name can't be empty";
    } else if (model.value.name!.contains(RegExp(r'\s'))) {
      return "Name can't contain spaces";
    }
    return null;
  }

  String? validateEmail() {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (model.value.email != null && emailRegex.hasMatch(model.value.email!)) return null;
    return "Please enter a valid Email address.";
  }

  Future<void> submit(BuildContext context) async {
    if (message == null || message!.isEmpty || message!.length < 20) return;

    try {
      final data = {
        'user': userController.id,
        'name': name,
        'email': email,
        'about': about,
        'issue': issue,
        'message': message,
      };

      final response = await _dio.post(
        "$host/feedback/",
        data: data,
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        pageIndex = 2; // greet the user for feedback
      } else {
        if (context.mounted) {
          Navigator.of(context).pop(); // close feedback sheet
          if (kDebugMode) debugPrint('inside feedback submit function , Error : ${response.statusMessage}');
          showToastMessage(context,
              "unable to send feedback, Try again later"); // show message
        }
      }
    } catch (error) {
      if (context.mounted) {
        Navigator.of(context).pop(); // close feedback sheet
        if (kDebugMode) debugPrint('inside feedback submit function , Error : $error');
        showToastMessage(context,
            "unable to send feedback, Try again later"); // show message
      }
    }
  }
}
