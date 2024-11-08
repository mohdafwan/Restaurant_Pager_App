import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restuarant_pager_app/controllers/tickets/ticket_history_controller.dart';
import 'package:restuarant_pager_app/widgets/ticket_history_card.dart';
import '../../controllers/notification/notification_settrings_controller.dart';

class TicketHistoryPage extends StatelessWidget {
  final TicketController controller = Get.put(TicketController());
  final NotificationsSettingsController settingsController =
      Get.find<NotificationsSettingsController>();

  TicketHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff7f9fa),
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          backgroundColor: const Color(0xfff7f9fa),
          title: const Text(
            'Ticket history',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.find<DashboardController>().changeTabIndex(2),
          ),
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.tickets.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  TicketItem(ticket: controller.tickets[index]),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
