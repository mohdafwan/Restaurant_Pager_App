import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackDialog.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackGreet.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackInitialScreen.dart';
import 'package:restuarant_pager_app/views/FeedBack/components/FeedBackScreen1.dart';

void showFeedBackForm(BuildContext context) async {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const FeedBackSheet();
    },
  ).whenComplete(() {
    Get.delete<FeedBackSheetController>();
  });
}

class FeedBackSheet extends StatefulWidget {
  const FeedBackSheet({super.key});

  @override
  State<FeedBackSheet> createState() => _FeedBackSheetState();
}

class _FeedBackSheetState extends State<FeedBackSheet> with TickerProviderStateMixin {
  late List<Widget> pages;
  final _controller = Get.put(FeedBackSheetController());
  @override
  void initState() {
    pages = [
      FeedBackInitialScreen(context),
      const FeedBackScreen1(),
      FeedBackGreetScreen()
    ];
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final keyboardHeight = mediaQuery.viewInsets.bottom;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.only(bottom: (keyboardHeight)),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 11.56,
                right: 15,
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    onPressed: () {
                      if (_controller.message != null &&
                          _controller.message!.isNotEmpty &&
                          _controller.pageIndex != 2) {
                        showDialog(
                            context: context,
                            barrierColor: Colors.transparent,
                            builder: (context) {
                              return FeedBackDialogBox(
                                discard: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                              );
                            });
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    padding: const EdgeInsets.all(0),
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromRGBO(1, 1, 4, 1),
                      size: 16,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(227, 229, 231, 1),
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
              ),
              Obx(() {
                return pages[_controller.pageIndex];
              }),
            ],
          ),
        ),
      ),
    );
  }
}
