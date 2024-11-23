import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/OrderHistoryController/OrderHistoryController.dart';
import 'package:restuarant_pager_app/views/main_screens/history_screen/components/FilterSheet.dart';

class FeatureBar extends StatefulWidget {
  const FeatureBar({super.key});

  @override
  State<FeatureBar> createState() => _FeatureBarState();
}

class _FeatureBarState extends State<FeatureBar> {
  final OrderHistoryController controller = Get.put(OrderHistoryController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          _searchBar(context),
          const SizedBox(
            width: 16,
          ),
          _filterButton(context)
        ],
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Expanded(
      child: TextField(
        style: GoogleFonts.inter(
          color: const Color.fromRGBO(17, 17, 17, 1),
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        controller: controller.search,
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          isCollapsed: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/historyimages/searchicon.png",
              width: 20,
              height: 20,
            ),
          ),
          hintText: "Search for orders",
          hintStyle: GoogleFonts.inter(
            color: const Color.fromRGBO(17, 17, 17, 0.7),
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(229, 233, 235, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(229, 233, 235, 1),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _filterButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showFilterSheet(context);
      },
      child: Stack(
        children: [
          Container(
            width: 85,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromRGBO(234, 236, 240, 1),
                  width: 1,
                )),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Filter",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 18,
                    height: 18,
                    child: SvgPicture.asset("assets/historyimages/filter.svg"),
                  )
                ],
              ),
            ),
          ),
          Obx(() {
            if (controller.selectedTags.isNotEmpty) {
              return Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(211, 54, 54, 1),
                  ),
                  child: Center(
                    child: Text(
                      controller.selectedTags.length.toString(),
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        color: const Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink(); 
            }
          }),
        ],
      ),
    );
  }
}
