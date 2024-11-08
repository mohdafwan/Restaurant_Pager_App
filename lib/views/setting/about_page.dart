import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../FeedBack/FeedBackSheet.dart';
import 'components/setting_tile.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        title: Text(
          'About',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: const Color.fromRGBO(73, 73, 73, 1),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingTile(
              title: 'Terms & Conditions',
              icon: Icons.info_outline,
              onTap: () {
                Get.toNamed("/t&c");
              },
            ),
            SettingTile(
              title: 'Privacy Policy',
              icon: Icons.privacy_tip_outlined,
              onTap: () {
                Get.toNamed("/privacy");
              },
            ),
            SettingTile(
              title: 'Send Feedback',
              icon: Icons.feedback_outlined,
              onTap: () {
                showFeedBackForm(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
