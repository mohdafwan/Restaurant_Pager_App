import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/OrderHistoryController/OrderHistoryController.dart';
import 'package:restuarant_pager_app/views/FeedBack/FeedBackSheet.dart';
import 'package:restuarant_pager_app/views/main_screens/history_screen/components/FeatureBar.dart';
import 'package:restuarant_pager_app/views/main_screens/history_screen/components/OrderTile.dart';
import 'package:restuarant_pager_app/widgets/CustomCircularProgressIndicator.dart';

class OrderHistoryView extends StatelessWidget {
  final OrderHistoryController controller = Get.find<OrderHistoryController>();

  OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          "My Order",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xff090A0A)),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.white,
            offset: const Offset(-23, 35),
            iconSize: 30,
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  padding: const EdgeInsets.only(
                      top: 6, bottom: 6, left: 15, right: 15),
                  height: 8,
                  enabled: true,
                  onTap: () {
                    showFeedBackForm(context);
                  },
                  child: const Text(
                    "Send feedback",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FeatureBar(),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CustomCircularProgressIndicator());
                } else if (controller.hasError.value) {
                  return Center(child: Text(controller.errorMessage.value));
                } else if (controller.allOrders.isEmpty) {
                  return Center(
                      child: Text(
                    controller.errorMessage.value,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color.fromRGBO(30, 30, 30, 1)),
                  ));
                } else {
                  if (controller.filtering.value) {
                    int filterOrdersCount = controller.filteredOrders.length;
                    if (filterOrdersCount == 0) {
                      return Center(
                          child: Text(
                        controller.errorMessage.value,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: const Color.fromRGBO(30, 30, 30, 1)),
                      ));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.resultMessage.value,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                                color: const Color.fromRGBO(95, 99, 104, 1))),
                        Column(
                          children: List.generate(filterOrdersCount, (index) {
                            return OrderTile(
                                order: controller.filteredOrders[index]);
                          }),
                        ),
                        const Divider(
                          height: 1,
                          color: Color.fromRGBO(242, 244, 245, 1),
                        ),
                        const SizedBox(height: 16,),
                        Center(
                          child: Text(
                            "End of Search results",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              color: const Color.fromRGBO(95, 99, 104, 1),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                  int activeOrdersCount = controller.activeOrders.length;
                  int completedOrdersCount = controller.completedOrders.length;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (activeOrdersCount > 0) ...[
                        Text(
                          "Active Orders",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: const Color.fromRGBO(95, 99, 104, 1),
                          ),
                        ),
                        Column(
                          children: List.generate(activeOrdersCount, (index) {
                            return OrderTile(
                                order: controller.activeOrders[index]);
                          }),
                        ),
                      ],
                      if (completedOrdersCount > 0) ...[
                        Text(
                          "Completed Orders",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: const Color.fromRGBO(95, 99, 104, 1),
                          ),
                        ),
                        Column(
                          children: List.generate(completedOrdersCount, (index) {
                            return OrderTile(
                                order: controller.completedOrders[index]);
                          }),
                        ),
                      ],
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
