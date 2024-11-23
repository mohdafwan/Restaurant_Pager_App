import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restuarant_pager_app/models/OrderHistory/OrderModel.dart';

void showOrderBottomSheet(BuildContext context, OrderModel order) {
  showModalBottomSheet(
    isDismissible: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(13)),
    ),
    backgroundColor: const Color(0xffFAFAFA).withOpacity(0.93),
    context: context,
    builder: (context) {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(13)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: const Color(0xffD9D9D9),
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(order.imgUrl),
                                  radius: 34),
                            ),
                            const SizedBox(height: 12),
                            Text(order.restaurantName,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ),
            
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(height: 1, color: const Color(0xffDADADA)),
                    ),
            
                    // ignore: prefer_const_constructors
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 17),
                      child: Column(
                        children: [
                          IconList(
                              icon: Icons.location_pin,
                              text: order.address),
                          const SizedBox(height: 5),
                          IconList(
                              icon: Icons.calendar_month,
                              text: "Date of order : ${order.orderDate}"),
                          const SizedBox(height: 5),
                          IconList(
                              icon: CupertinoIcons.bag_fill,
                              text: "Delivered on ${order.deliveryData}"),
                          const SizedBox(height: 5),
                          IconList(
                              icon: CupertinoIcons.creditcard_fill,
                              text: "Order id : #${order.id}"),
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 133,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFD4712),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  "Unlink",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  deletePopUp(context);
                                },
                                child: Container(
                                  width: 133,
                                  height: 35,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: const Color.fromRGBO(247, 248, 249, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Delete",
                                    style: TextStyle(
                                      color: Color(0xff303030),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFF4ED),
                        borderRadius: BorderRadius.circular(100)),
                    child: const Icon(
                      Icons.close,
                      color: Color(0xff76757A),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      );
    },
  );
}

Future<dynamic> deletePopUp(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xffFFEFE4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.warning_rounded,
                              color: Color(0xffFA5C00)),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Delete",
                                  style: TextStyle(
                                      color: Color(0xff11151F),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                width: 160,
                                child: Text("Are you sure want to delete?",
                                    softWrap: true),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  // ---------- Yes ------ no ----

                                  Container(
                                    width: 49,
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      "Yes",
                                      style: TextStyle(
                                        color: Color(0xff445275),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 49,
                                    height: 32,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      "No",
                                      style: TextStyle(
                                        color: Color(0xff445275),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.35),
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Color(0xff445275),
                          ),
                        ),
                      )
                    ]),
              ],
            ));
      });
}

class IconList extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconList({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: const Color(0xffFFF4ED),
          child: Icon(
            icon,
            size: 14,
            color: const Color(0xffFD4712),
          ),
        ),
        const SizedBox(width: 7),
        Text(
          text,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xff565D6D)),
        )
      ],
    );
  }
}
