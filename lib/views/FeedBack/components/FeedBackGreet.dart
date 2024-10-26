import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';

class FeedBackGreetScreen extends StatelessWidget {
  FeedBackGreetScreen({super.key});
  final _controller = Get.find<FeedBackSheetController>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           const SizedBox(
                height: 13,
              ),
              Text(
                _controller.about != null && _controller.about! == 'suggest an idea'?
                'Suggest an Idea':'Send Feedback',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color.fromRGBO(30, 30, 30, 1)),
              ),
              const SizedBox(
                height: 23,
              ),
          SvgPicture.asset(
            'assets/feedBackAssets/Greet.svg',
            width: 205,
            height: 142.02,
          ),
          const SizedBox(
            height: 15.98,
          ),
          Text(
            'Thanks for Sharing your Feedback!',
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: const Color.fromRGBO(30, 30, 30, 1)),
          ),
          const SizedBox(height: 10,),
          Text(
            'We rely on feedback like yours to address issues and\nenhance our Service',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color.fromRGBO(30, 30, 30,0.5)
                ),
          ),
          const SizedBox(height: 38,)
        ],
      ),
    );
  }
}