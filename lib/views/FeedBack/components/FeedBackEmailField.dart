import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
import 'package:restuarant_pager_app/controllers/FeedBackSheet/FeedBackSheetController.dart';

class FeedBackFormEmailField extends StatefulWidget {
  final Function(String) showSnackbar;
  const FeedBackFormEmailField({super.key, required this.showSnackbar});

  @override
  State<FeedBackFormEmailField> createState() => _FeedBackFormEmailFieldState();
}

class _FeedBackFormEmailFieldState extends State<FeedBackFormEmailField> {
  late TextEditingController emailController;
   final _controller = Get.find<FeedBackSheetController>();
  FocusNode focusNode = FocusNode();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: _controller.email ?? "");
    focusNode.addListener(() {
      setState(() {
        isEditing = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value){
        final result = _controller.validateEmail();
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
              "Email Id",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color.fromRGBO(32, 37, 56, 1),
              ),
            ),
            const SizedBox(height: 13),
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: state.hasError
                      ? const Color.fromRGBO(253, 162, 155, 1)
                      : isEditing
                          ? themeColor
                          : const Color.fromRGBO(216, 218, 220, 1),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: fontColor,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(128, 128, 128, 1),
                        ),
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (email) => _controller.updateEmail(email),
                      focusNode: focusNode,
                      readOnly: !isEditing, // Make it read-only if not editing
                    ),
                  ),
                  if (state.hasError)
                  const Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Color.fromRGBO(253, 162, 155, 1),
                    ),
                  )
                ],
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
