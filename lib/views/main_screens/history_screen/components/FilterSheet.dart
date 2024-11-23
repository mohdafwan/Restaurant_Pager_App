import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/OrderHistoryController/OrderHistoryController.dart';
import 'package:restuarant_pager_app/widgets/Button.dart';

void showFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const FilterSheet();
    },
  );
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  final controller = Get.find<OrderHistoryController>();
  final date = DateTime.now();
  late List<String> tags;

  @override
  void initState() {
    super.initState();
    tags = List<String>.from(controller.selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13),
          topRight: Radius.circular(13),
        ),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Filters",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color.fromRGBO(30, 30, 30, 1)),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    tags.clear();
                  });
                },
                child: Text(
                  "Clear Filters",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: const Color.fromRGBO(30, 30, 30, 0.5),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Order Status",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: const Color.fromRGBO(30, 30, 30, 1),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 24,
            runAlignment: WrapAlignment.start,
            runSpacing: 10,
            children: [
              _option(
                context: context,
                text: "Ready to pickup",
                selected: tags.contains(controller.ready),
                onTap: () {
                  setState(() {
                    if (tags.contains(controller.ready)) {
                      tags = List.from(tags)..remove(controller.ready);
                    } else {
                      tags = List.from(tags)..add(controller.ready);
                    }
                  });
                },
              ),
              _option(
                context: context,
                text: "Preparing",
                selected: tags.contains(controller.going),
                onTap: () {
                  setState(() {
                    if (tags.contains(controller.going)) {
                      tags = List.from(tags)..remove(controller.going);
                    } else {
                      tags = List.from(tags)..add(controller.going);
                    }
                  });
                },
              ),
              _option(
                context: context,
                text: "Completed",
                selected: tags.contains(controller.completed),
                onTap: () {
                  setState(() {
                    if (tags.contains(controller.completed)) {
                      tags = List.from(tags)..remove(controller.completed);
                    } else {
                      tags = List.from(tags)..add(controller.completed);
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            "Order Time",
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: const Color.fromRGBO(30, 30, 30, 1),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 24,
            runAlignment: WrapAlignment.start,
            runSpacing: 10,
            children: [
              _option(
                context: context,
                text: controller.last30Days,
                selected: tags.contains(controller.last30Days),
                onTap: () {
                  setState(() {
                    if (tags.contains(controller.last30Days)) {
                      tags = List.from(tags)..remove(controller.last30Days);
                    } else {
                      tags = List.from(tags)..add(controller.last30Days);
                    }
                  });
                },
              ),
              _option(
                context: context,
                text: controller.last6Months,
                selected: tags.contains(controller.last6Months),
                onTap: () {
                  setState(() {
                    if (tags.contains(controller.last6Months)) {
                      tags = List.from(tags)..remove(controller.last6Months);
                    } else {
                      tags = List.from(tags)..add(controller.last6Months);
                    }
                  });
                },
              ),
              _option(
                context: context,
                text: controller.thisYear,
                selected: tags.contains(controller.thisYear),
                onTap: () {
                  setState(() {
                    if (tags.contains(controller.thisYear)) {
                      tags = List.from(tags)..remove(controller.thisYear);
                    } else {
                      tags = List.from(tags)..add(controller.thisYear);
                    }
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(
            height: 1,
            color: Color.fromRGBO(242, 244, 245, 1),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Button(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: "Cancel",
                width: 133,
                height: 40,
                color: const Color.fromRGBO(247, 248, 249, 1),
                textColor: const Color.fromRGBO(48, 48, 48, 1),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              Button(
                onPressed: () {
                  controller.selectedTags = tags; 
                  Navigator.of(context).pop();
                },
                text: "Apply",
                width: 133,
                height: 40,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _option({
    required BuildContext context,
    required String text,
    required bool selected,
    required void Function() onTap,
  }) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 94),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
            textStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: const Color.fromRGBO(75, 75, 75, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            backgroundColor: selected
                ? const Color.fromRGBO(255, 244, 237, 1)
                : const Color.fromRGBO(242, 244, 247, 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: const Color.fromRGBO(75, 75, 75, 1),
          ),
        ),
      ),
    );
  }
}

