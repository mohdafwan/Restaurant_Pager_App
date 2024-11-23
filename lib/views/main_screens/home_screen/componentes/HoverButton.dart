import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HoverButton extends StatefulWidget {
  final void Function()? onTap;
  final String text; 
  const HoverButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value){
        setState(() {
          isHovering = value;
        });
      },
      child: Container(
        width: double.infinity * 0.6,
        height: 39,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isHovering ? const Color.fromRGBO(252, 68, 14, 1) : null,
            border: Border.all(
              color: const Color.fromRGBO(252, 68, 14, 1),
              width: 1,
            )),
        child: Center(
          child: Text(
            widget.text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isHovering ? Colors.white: const Color.fromRGBO(252, 68, 14, 1),
            ),
          ),
        ),
      ),
    );
  }
}
