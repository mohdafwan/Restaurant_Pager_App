import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';
import 'package:super_tooltip/super_tooltip.dart';

class FeedBackMessageBox extends StatefulWidget {
  final bool report;
  final Function(String) showSnackbar;
  const FeedBackMessageBox(
      {super.key, required this.report, required this.showSnackbar});

  @override
  State<FeedBackMessageBox> createState() => _FeedBackMessageBoxState();
}

class _FeedBackMessageBoxState extends State<FeedBackMessageBox> {
  late FeedBackSheetController controller;
  final _controller = SuperTooltipController();
  @override
  void initState() {
    controller = Get.find<FeedBackSheetController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.report
              ? 'Can you describe the issue you\'re experiencing?'
              : 'Could you please share your ideas and suggestions?',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: const Color.fromRGBO(30, 30, 30, 1)),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Please dont include sensitive information',
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: const Color.fromRGBO(30, 30, 30, 0.8)),
            ),
            SizedBox(
              height: 16,
              width: 16,
              child: IconButton(
                onPressed: () {
                  widget.showSnackbar(
                      'Don\'t share passwords, credit card\n numbers & personal details.');
                },
                padding: const EdgeInsets.all(0),
                icon: const Icon(
                  Icons.help_outline,
                  color: Color.fromRGBO(0, 0, 0, 1),
                  size: 16,
                ),
              ),
            )
          ],
        ),
        SuperTooltip(
          showBarrier: false,
          hasShadow: false,
          arrowBaseWidth: 16,
          arrowLength: 7,
          popupDirection: TooltipDirection.up,
          backgroundColor: const Color.fromRGBO(255, 244, 237, 1),
          borderColor: const Color.fromRGBO(255, 244, 237, 1),
          controller: _controller,
          content: SizedBox(
            width: 179,
            height: 105,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Text(
                    'Add More Detail',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: const Color.fromRGBO(52, 64, 84, 1)),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Center(
                  child: Text(
                    'Could you provide additional\ndetails to help us better\nunderstand your feedback?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: const Color.fromRGBO(52, 64, 84, 1)),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: 42,
                  height: 30,
                  child: TextButton(
                    onPressed: () {
                      _controller.hideTooltip();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 199, 169, 1),
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                    ),
                    child: Center(
                      child: Text(
                        'OK',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: const Color.fromRGBO(52, 64, 84, 1)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          child: const Center(
            child: SizedBox(
            height: 8,
                    ),
          ),
        ),
        SizedBox(
            width: 315,
            height: 194,
            child: TextField(
              cursorColor: const Color.fromRGBO(30, 30, 30, 1),
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: const Color.fromRGBO(30, 30, 30, 1)),
              decoration: InputDecoration(
                hintText: 'Tell us how can we improve our Product',
                hintStyle: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, fontSize: 12),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: themeColor, width: 1)),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromRGBO(218, 218, 218, 1), width: 1),
                ),
                contentPadding: const EdgeInsets.all(12),
              ),
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              onChanged: (text) {
                controller.message = text;
              },
              onTapOutside: (event){
                if(controller.message != null && controller.message!.length < 20){
                  _controller.showTooltip();
                }
              },
            ),
          ),
      ],
    );
  }
}
