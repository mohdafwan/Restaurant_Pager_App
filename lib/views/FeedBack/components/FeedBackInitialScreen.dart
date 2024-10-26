import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';

Widget FeedBackInitialScreen(BuildContext context) {
  return SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          'Send Feedback to Quvoid',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.21,
              color: const Color.fromRGBO(30, 30, 30, 1)),
        ),
        const SizedBox(
          height: 26,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 244, 237, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/feedBackAssets/Answer.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'Answer a Few\nQuestions',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 14),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 244, 237, 1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/feedBackAssets/ShareFeedback.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Text(
                  'Share Your\nFeedback',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 14),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 26,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text:
                  'Certain account and system information may be\ntransmitted to Quvoid in accordance with our\n',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: const Color.fromRGBO(20, 28, 36, 1)),
              children: [
                TextSpan(
                  text: 'Privacy Policy',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color.fromRGBO(253, 71, 18, 1)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // handle tap privacy policy
                    },
                ),
                TextSpan(
                  text: ' and ',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color.fromRGBO(20, 28, 36, 1)),
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color.fromRGBO(253, 71, 18, 1)),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // handle tap terms and condition
                    },
                ),
                TextSpan(
                  text: '.',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: const Color.fromRGBO(20, 28, 36, 1)),
                ),
              ]),
        ),
        const SizedBox(
          height: 35,
        ),
        // button
        SizedBox(
          width: 171,
          height: 37,
          child: TextButton(
            onPressed: () {
              Get.find<FeedBackSheetController>().pageIndex = 1;
            },
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              backgroundColor: const Color.fromRGBO(255, 244, 237, 1),
              foregroundColor: Colors.white,
            ),
            child: Text(
              'Get Started',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.21,
                  color: const Color.fromRGBO(253, 71, 18, 1)),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    ),
  );
}
