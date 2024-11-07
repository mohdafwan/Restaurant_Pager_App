import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/views/TermsAndCondition/TermsAndConditonView.dart';

class TermsAndConditons extends StatelessWidget {
  const TermsAndConditons({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'By creating an account or signing in, you\n agree to our ',
        style: GoogleFonts.inter(
          textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.25,
            color: Color.fromRGBO(0, 0, 0, 0.7),
          ),
        ),
        children: [
          TextSpan(
            text: 'Terms and Conditions',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
                color: fontColor,
                height: 1.21,
              ),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TermsAndConditionView()));
              },
          ),
          const TextSpan(
            text: '.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
