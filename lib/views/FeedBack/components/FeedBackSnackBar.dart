import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showFeedBackSnackBar({required BuildContext context, required String text}) {
  final overlay = Overlay.of(context);
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 1,
      left: 0,
      right: 0,
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(242, 244, 245, 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: const Color.fromRGBO(30, 30, 30, 1),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (overlayEntry!.mounted) {
                    overlayEntry.remove();
                  }
                },
                child: const Text(
                  "Ok",
                  style: TextStyle(
                    color: Color.fromRGBO(253, 71, 18, 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  overlay.insert(overlayEntry);
  Future.delayed(const Duration(seconds: 30), () {
    if (overlayEntry!.mounted) {
      overlayEntry.remove();
    }
  });
}
