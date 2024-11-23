import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart' as dio;
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/widgets/CustomCircularProgressIndicator.dart';

class FrequentlyAskedQuestion extends StatelessWidget {
  const FrequentlyAskedQuestion({super.key});

  Future<Map<String, String>?> fetch() async {
  final dio.Dio _dio = dio.Dio();
  try {
    final response = await _dio.get("$host/faq/");
    if (response.statusCode == 200 && response.data != null) {
      final data = response.data as Map<String, dynamic>;
      final result = data.map((key, value) => MapEntry(key.toString(), value.toString()));
      return result;
    }
  } catch (error) {
    if (kDebugMode) {
      print("error fetching terms and conditions data : $error");
    }
  }
  return null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
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
                FutureBuilder(
                  future: fetch(),
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child: CustomCircularProgressIndicator(),
                      );
                    }else if(snapshot.hasError){
                      return Center(
                        child: Text(
                          "Failed to Fetch data",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                          ),
                        ),
                      );
                    }
                    final data = snapshot.data;
                    return ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: data!.entries.map((entry) {
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
                      );
                  },
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
