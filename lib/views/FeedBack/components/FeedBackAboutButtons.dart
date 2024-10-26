import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';

class FeedBackAboutButtons extends StatelessWidget {
  final bool Function() validate;
  final _controller = Get.find<FeedBackSheetController>();
  FeedBackAboutButtons({super.key, required this.validate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color.fromRGBO(224, 224, 224, 1),
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _controller.about = 'report an issue';
              if (validate()) {
                _controller.counter = -1;
                Timer(const Duration(seconds: 2),(){
                  _controller.counter = 1;
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 244, 237, 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/feedBackAssets/Report.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      'Report an Issue',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: const Color.fromRGBO(30, 30, 30, 1)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Please report any issues or unusual findings.',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 13,
          ),
          const Divider(
            color: Color.fromRGBO(205, 207, 212, 1),
            thickness: 1,
          ),
          const SizedBox(
            height: 13,
          ),
          GestureDetector(
            onTap: () {
              _controller.about = 'suggest an idea';
              if (validate()) {
                _controller.counter = -1;
                Timer(const Duration(seconds: 2),(){
                  _controller.counter = 2;
                });
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 244, 237, 1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/feedBackAssets/ShareIdea.svg',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 9,
                    ),
                    Text(
                      'Suggest an Idea',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: const Color.fromRGBO(30, 30, 30, 1)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Please report any issues or unusual findings.',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
