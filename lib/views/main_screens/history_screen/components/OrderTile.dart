import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/OrderHistoryController/OrderHistoryController.dart';
import 'package:restuarant_pager_app/models/OrderHistory/OrderModel.dart';
import 'package:restuarant_pager_app/views/main_screens/history_screen/components/OrderBottomSheet.dart';

class OrderTile extends StatefulWidget {
  final OrderModel order;
  const OrderTile({super.key, required this.order});

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  late DateTime parsedDate;
  final controller = Get.find<OrderHistoryController>();
  late Map<String,String> status;
  @override
  void initState() {
    parsedDate = DateFormat('dd-MM-yy').parse(widget.order.orderDate);
    status = {
      controller.completed: "",
      controller.ready : "Ready to pickup",
      controller.going : "Preparing",
    };
    super.initState();
  }

  String formatDate(DateTime date) {
    String day = DateFormat('d').format(date);
    String dayWithSuffix = '$day${getDaySuffix(int.parse(day))}';
    String month = DateFormat('MMMM').format(date);
    return '$month $dayWithSuffix';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: const Color(0xffD9D9D9),
          child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage:
                  NetworkImage(widget.order.imgUrl) as ImageProvider,
              radius: 22),
        ),
        title: Text(
          widget.order.restaurantName,
          style: const TextStyle(
              color: Color(0xff344054),
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          parsedDate == DateTime.now() ? "Today" : "${formatDate(parsedDate)} ${widget.order.deliveryData}",
          style: const TextStyle(
              color: Color(0xff444444),
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        trailing: Text(
          status[widget.order.orderStatus]!,
          style: TextStyle(
              color: widget.order.orderStatus == controller.ready
                  ? const Color(0xff069855)
                  : const Color(0xffFC440E),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        onTap: () => showOrderBottomSheet(context, widget.order),
      ),
    );
  }
}
