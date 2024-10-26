import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackLabel extends StatelessWidget {
  final String text;
  final bool selected;
  final Function()? onTap;
  const FeedBackLabel({super.key, required this.text,this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: selected ? null: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selected? const Color.fromRGBO(235, 235, 238, 1) : const Color.fromRGBO(255, 255, 255, 1),
          border: selected?null:Border.all(
            width: 1,
            color: const Color.fromRGBO(30, 30, 30, 1)
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: const Color.fromRGBO(0, 0, 0, 1)
          ),
        ),
      ),
    );
  }
}