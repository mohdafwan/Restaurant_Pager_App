import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';

class FeedBackFormNameField extends StatefulWidget {
  final Function(String) showSnackbar;
  const FeedBackFormNameField({super.key, required this.showSnackbar});

  @override
  State<FeedBackFormNameField> createState() => _feedBackFormNameFieldState();
}

class _feedBackFormNameFieldState extends State<FeedBackFormNameField> {
  final _controller = Get.find<FeedBackSheetController>();
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController(text: _controller.name ?? "");
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value){
        final result = _controller.validateName();
        if(result != null){
          widget.showSnackbar(result);
        }
        return result;
      },
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(32, 37, 56, 1),
              ),
            ),
            const SizedBox(height: 13),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: TextFormField(
                controller: nameController,
                cursorColor: fontColor,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Enter your name here",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(128, 128, 128, 1),
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: state.hasError
                          ? const Color.fromRGBO(253, 162, 155, 1)
                          : const Color.fromRGBO(216, 218, 220, 1),
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: state.hasError
                          ? const Color.fromRGBO(253, 162, 155, 1)
                          : const Color.fromRGBO(216, 218, 220, 1),
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(
                      color: themeColor,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onChanged: (text) {
                  _controller.updateName(text);
                },
              ),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  state.errorText ?? "",
                  style: const TextStyle(
                    color: Color.fromRGBO(240, 68, 56, 1),
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}