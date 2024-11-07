import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Map<String, String> faqData = {
  "What is Flutter?": "Flutter is an open-source UI software development kit created by Google for building natively compiled applications for mobile, web, and desktop from a single codebase.",
  "How do I install Flutter?": "To install Flutter, visit the official Flutter website (https://flutter.dev), and follow the installation instructions for your operating system.",
  "What programming languages are used in Flutter?": "Flutter uses the Dart programming language, which is easy to learn and efficient for building high-performance apps.",
  "What platforms can I target with Flutter?": "Flutter allows you to build apps for Android, iOS, web, desktop (Windows, macOS, Linux), and embedded devices.",
  "How do I run a Flutter app?": "After installing Flutter, you can run your app by using the `flutter run` command in your terminal or by using your IDE's built-in tools.",
  "Can I use Flutter for production apps?": "Yes, many companies use Flutter for production apps, including Google, Alibaba, and BMW.",
  "Is Flutter free to use?": "Yes, Flutter is completely free and open-source. It is licensed under the BSD 3-Clause License.",
  "How can I contribute to Flutter?": "You can contribute to Flutter by visiting the official GitHub repository (https://github.com/flutter/flutter), reporting issues, and submitting pull requests.",
  "What are Flutter widgets?": "Widgets are the basic building blocks of a Flutter app's user interface. Everything in Flutter is a widget, including layout elements, controls, and even the app itself.",
  "How do I debug a Flutter app?": "You can debug a Flutter app using the `flutter run` command in debug mode or by using breakpoints in your IDE. Flutter also provides excellent support for hot reload and hot restart."
};

class FrequentlyAskedQuestion extends StatelessWidget {
  const FrequentlyAskedQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Frequently Asked Questions',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: const Color.fromRGBO(16, 24, 40, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Everything you need to know about the\nproduct and billing.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color.fromRGBO(102, 112, 133, 1),
                      ),
                    ),
                  ],
                ),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(), 
                  children: faqData.entries.map((entry) {
                    return Column(
                      children: [
                        Question(entry.key, entry.value),
                        const Divider(
                          color: Color.fromRGBO(234, 236, 240, 1),
                          height: 1,
                        )
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Question(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: ExpansionTile(
        collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide.none,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide.none,
        ),
        iconColor: const Color.fromRGBO(253, 71, 18, 1),
        collapsedIconColor: const Color.fromRGBO(253, 71, 18, 1),
        title: Text(
          question,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: const Color.fromRGBO(16, 24, 40, 1),
          ),
        ),
        tilePadding: const EdgeInsets.symmetric(horizontal: 4),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
        expandedCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 4),
          Text(
            answer,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color.fromRGBO(102, 112, 133, 1),
            ),
          ),
        ],
      ),
    );
  }
}
