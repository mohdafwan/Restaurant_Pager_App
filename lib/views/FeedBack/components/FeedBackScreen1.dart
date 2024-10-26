import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackAboutButtons.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackEmailField.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackLabel.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackLoading.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackMessageBox.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackNameField.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackSnackBar.dart';

class FeedBackScreen1 extends StatefulWidget {
  const FeedBackScreen1({super.key});

  @override
  State<FeedBackScreen1> createState() => _FeedBackScreen1State();
}

class _FeedBackScreen1State extends State<FeedBackScreen1> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<FeedBackSheetController>();
  bool validate() {
    return _formKey.currentState!.validate();
  }

  @override
  void initState() {
    super.initState();
  }

  void showSnackBar(String text) {
    showFeedBackSnackBar(context: context, text: text);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 13,
              ),
              Center(
                child: Text(
                  _controller.about != null && _controller.about! == 'suggest an idea'?
                  'Suggest an Idea':'Send Feedback',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              if (_controller.counter == 0)
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FeedBackFormNameField(showSnackbar: showSnackBar),
                      const SizedBox(
                        height: 16,
                      ),
                      FeedBackFormEmailField(showSnackbar: showSnackBar),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              // permanent
              Text(
                'What is your feedback about?',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: const Color.fromRGBO(30, 30, 30, 1)),
              ),
              const SizedBox(
                height: 8,
              ),
              if (_controller.counter == 0) ...[
                FeedBackAboutButtons(validate: validate),
                const SizedBox(
                  height: 47.92,
                )
              ],

              // permanent
              if(_controller.about != null)...[
                FeedBackLabel(
                  text: _controller.about!,
                  selected: true,
                ),
                const SizedBox(height: 19),
                const Center(child: WaveDots()),
              ],
              
              if(_controller.about == 'report an issue' && _controller.counter != -1)...[
                const SizedBox(height: 10), 
                Text(
                  'What were you trying to do when you noticed the issue?',
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: const Color.fromRGBO(30, 30, 30, 1)),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              
              if (_controller.counter == 1) ...[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FeedBackLabel(
                          text: 'QR Code',
                          onTap: () {
                            _controller.issue = 'QR Code';
                            _controller.counter = -2;
                            Timer(const Duration(seconds: 2), () {
                              _controller.counter = 3;
                            });
                          },
                        ),
                        const SizedBox(width: 10,),
                        FeedBackLabel(
                          text: 'Order',
                          onTap: () {
                            _controller.issue = 'Order';
                           _controller.counter = -2;
                            Timer(const Duration(seconds: 2), () {
                              _controller.counter = 3;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FeedBackLabel(
                          text: 'Alert Error',
                          onTap: () {
                            _controller.issue = 'QR Code';
                            _controller.counter = -2;
                            Timer(const Duration(seconds: 2), () {
                              _controller.counter = 3;
                            });
                          },
                        ),
                        const SizedBox(width: 10,),
                        FeedBackLabel(
                          text: 'Other',
                          onTap: () {
                            _controller.issue = 'Other';
                            _controller.counter = -2;
                            Timer(const Duration(seconds: 2), () {
                              _controller.counter = 3;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 47.92,
                    )
                  ],
                )
              ],
              if(_controller.issue != null )...[
                FeedBackLabel(
                  text: _controller.issue!,
                  selected: true,
                ),
                const SizedBox(height: 19),
                const Center(child: WaveDots()),
              ],
              
              // animation

              // report an issue
              if(_controller.counter == 3 && _controller.counter != -2)...[
                const SizedBox(height: 10,),
                FeedBackMessageBox(report: true, showSnackbar: showSnackBar),
                const SizedBox(height: 10,),
              ],

              // suggest idea
              if(_controller.counter == 2 && _controller.counter != -2)...[
                const SizedBox(height: 10,),
                FeedBackMessageBox(report: false, showSnackbar: showSnackBar),
                const SizedBox(height: 10,),
              ],

              if(_controller.counter == 3 || _controller.counter == 2)...[
                sendButton(),
                const SizedBox(height: 12,)
              ]

            ],
          ),
        );
      }),
    );
  }

  Widget sendButton(){
    return Center(
      child: SizedBox(
        width: 171,
        height: 37,
        child: TextButton(
          onPressed: () {
            _controller.pageIndex = 2;
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10),
            backgroundColor: const Color.fromRGBO(255, 244, 237, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4)
            )
          ),
          child: Text(
            'Send',
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: const Color.fromRGBO(253, 71, 18, 1)
            ),
          ),
        ),
      ),
    );
  }
}
