import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/constants/ColorPalette.dart';
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
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchOrderHistory();
        },
        color: themeColor,
        backgroundColor: Colors.white,
        child: Obx(() {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: FeatureBar(),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 20),
              ),
              if (controller.isLoading.value)
                const SliverFillRemaining(
                  child: Center(child: CustomCircularProgressIndicator()),
                )
              else if (controller.hasError.value)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color.fromRGBO(30, 30, 30, 1),
                      ),
                    ),
                  ),
                )
              else if (controller.allOrders.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      controller.errorMessage.value,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: const Color.fromRGBO(30, 30, 30, 1),
                      ),
                    ),
                  ),
                )
              else
                ..._buildOrderSections(),
            ],
          );
        }),
      ),
    );
  }

  List<Widget> _buildOrderSections() {
    List<Widget> slivers = [];

    if (controller.filtering.value) {
      int filteredCount = controller.filteredOrders.length;
      slivers.add(SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            controller.resultMessage.value,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: const Color.fromRGBO(95, 99, 104, 1),
            ),
          ),
        ),
      ));
      if (filteredCount > 0) {
        slivers.add(SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return OrderTile(order: controller.filteredOrders[index]);
            },
            childCount: filteredCount,
          ),
        ));
        slivers.add(const SliverToBoxAdapter(
          child: Center(
            child: Text(
              "End of Search results",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: Color.fromRGBO(95, 99, 104, 1),
              ),
            ),
          ),
        ));
      }
    } else {
      if (controller.activeOrders.isNotEmpty) {
        slivers.add(SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Active Orders",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: const Color.fromRGBO(95, 99, 104, 1),
              ),
            ),
          ),
        ));
        slivers.add(SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return OrderTile(order: controller.activeOrders[index]);
            },
            childCount: controller.activeOrders.length,
          ),
        ));
      }
      if (controller.completedOrders.isNotEmpty) {
        slivers.add(SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Completed Orders",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: const Color.fromRGBO(95, 99, 104, 1),
              ),
            ),
          ),
        ));
        slivers.add(SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return OrderTile(order: controller.completedOrders[index]);
            },
            childCount: controller.completedOrders.length,
          ),
        ));
      }
    }

    return slivers;
  }
}
