import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/OrderHistoryController/OrderHistoryController.dart';
import 'package:restuarant_pager_app/views/main_screens/home_screen/componentes/HoverButton.dart';
import 'package:restuarant_pager_app/widgets/CustomCircularProgressIndicator.dart';

import 'componentes/refer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final orderController = Get.put(OrderHistoryController());
  final userController = Get.find<UserController>();
  final dashBoardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFE6E39),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xffFE6E39),
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            userController.name == null
                ? "Hi there,"
                : "Hi, ${userController.name}",
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              Get.find<DashboardController>().changeTabIndex(2);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: userController.profilePic == null
                  ? SvgPicture.asset("assets/homeImages/person_avatar.svg")
                  : CircleAvatar(
                      foregroundImage:
                          AssetImage("${userController.profilePic}"),
                    ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
          child: Column(
            children: [
              const Row(
                children: [
                  Text(
                    "Active orders",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff090A0A)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Obx(() {
                if (orderController.isLoading.value) {
                  // Loading state
                  return const Center(
                      child: CustomCircularProgressIndicator());
                } else if (orderController.hasError.value) {
                  // Error state
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.error_outline,
                            size: 60, color: Colors.red),
                        const SizedBox(height: 10),
                        Text(orderController.errorMessage.value,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black)),
                      ],
                    ),
                  );
                } else if (orderController.activeOrders.isEmpty) {
                  // No data state (empty list)
                  return Center(
                    child: Text(
                      'No Orders Yet!',
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: const Color.fromRGBO(20, 28, 36, 0.5)),
                    ),
                  );
                } else {
                  // Data state (display list of orders)
                  return Column(
                    children: List.generate(
                        min(orderController.activeOrders.length, 3), (index) {
                      return CurrentOrderTile(
                        title: orderController
                            .activeOrders[index].restaurantName,
                        place: orderController.activeOrders[index].address.replaceFirst(',', ',\n'),
                        status:
                            orderController.activeOrders[index].orderStatus,
                      );
                    }),
                  );
                }
              }),

              const SizedBox(height: 20),

              //View order history Btn
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: HoverButton(
                    text: "View order history",
                    onTap: () {
                      dashBoardController.changeTabIndex(1);
                    },
                  )),

              const SizedBox(height: 30),

              //Settings
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Settings",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff090A0A)),
                    ),
                    const SizedBox(height: 5),
                    InkWell(
                      //Setting page route
                      onTap: () {
                        Get.toNamed("/onsettingnotification");
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification settings",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff090A0A)),
                          ),
                          CircleAvatar(
                            backgroundColor: Color(0xffFBF5E8),
                            radius: 16,
                            child: Icon(
                              Icons.arrow_forward,
                              color: Color(0xff1E1E1E),
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const ReferFriendCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentOrderTile extends StatelessWidget {
  const CurrentOrderTile({
    super.key,
    required this.title,
    required this.place,
    required this.status,
  });
  final String title;
  final String place;
  final String status;

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderHistoryController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff6434F8).withOpacity(0.15),
                  offset: const Offset(1.5, 2.99),
                  blurRadius: 8.98,
                  spreadRadius: 0)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1E1E1E)),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(100)),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        place,
                        softWrap: true,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          color: Color(0xff1E1E1E),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    color: (status == orderController.going)
                        ? const Color(0xffFED7B3)
                        : const Color(0xffE6F5EE),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    status == orderController.going ? "Preparing" : status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.fade,
                      color: (status == orderController.going)
                          ? const Color(0xffFC440E)
                          : const Color(0xff069855),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
