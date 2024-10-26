import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/SignUpController/SignUpController.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/dateField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/emailField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/genderField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/messagePerference.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/nameField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/phoneNoField.dart';
import 'package:restuarant_pager_app/views/SignUpView/components/profilePic.dart';
import 'package:restuarant_pager_app/views/VerifyEmailUsingOTP/VerifyEmailUsingOTP.dart';
import 'package:restuarant_pager_app/widgets/TermsAndConditions.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  bool signUpUsingPhone = true;
  final SignUpController controller = Get.put(SignUpController());
  bool clicked = false;

  @override
  void initState() {
    super.initState();
    if (controller.emailAdress != null) {
      signUpUsingPhone = false;
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); 
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        clicked = false;
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      clicked = true;
    });
    if (signUpUsingPhone) {
      Get.to(const VerifyEmailUsingOTP());
    } else {
      controller.submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 44, top: 33),
          child: Text(
            "Personal Details",
            style: GoogleFonts.inter(
              color: fontColor,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              height: 1.3,
            ),
          ),
        ),
        surfaceTintColor: Colors.transparent,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 44),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Center(
                    child: ProfilePic(),
                  ),
                  const SizedBox(height: 16),
                  const NameField(),
                  const SizedBox(height: 16),
                  const DateField(),
                  const SizedBox(height: 16),
                  const GenderField(),
                  const SizedBox(height: 16),
                  const PhoneNoField(),
                  const SizedBox(height: 16),
                  const EmailField(),
                  const SizedBox(height: 30),
                  const MessagePerference(),
                  const SizedBox(height: 30),
                  Button(
                    onPressed: _submitForm,
                    text: "Create account",
                    disable: clicked,
                  ),
                  const SizedBox(height: 30),
                  const Center(
                    child: TermsAndConditons(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
