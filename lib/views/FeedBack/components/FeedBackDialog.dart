import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FeedBackDialogBox extends StatelessWidget {
  final Function() discard;
  const FeedBackDialogBox({super.key, required this.discard});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromRGBO(247, 249, 250, 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(37, 45, 53, 0.2),
                    offset: Offset(0, 4),
                    blurRadius: 32,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Discard Your Feddback',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color.fromRGBO(20, 28, 36, 1)
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Text(
                    'We would really like to hear from you. Are\nyou sure dont want to send this?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: const Color.fromRGBO(20, 28, 36, 1)
                    ),
                  ),
                  const SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: const Color.fromRGBO(228, 228, 228, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                        ),
                        child: Text(
                          'Continue Writing',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            color: const Color.fromRGBO(48, 48, 48, 1),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          discard();
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          backgroundColor: const Color.fromRGBO(253, 71, 18, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          )
                        ),
                        child: Text(
                          'Discard',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 9,
              right: 23,
              child: SizedBox(
                height: 24,
                width: 24,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(
                    Icons.close,
                    color: Color.fromRGBO(252, 68, 14, 1),
                    size: 16,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(255, 244, 237, 1),
                    shape: const CircleBorder(),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
