import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:share_plus/share_plus.dart';


class ReferFriendCard extends StatelessWidget {
  const ReferFriendCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 117,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xffFFF4ED),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 8.98,
                spreadRadius: 0,
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox(),
            ),
            SizedBox(
              width: 150,
              height: 117,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: OverflowBox(
                  maxHeight: 250,
                  maxWidth: 250,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 63.0),
                    child: Container(
                      height: 230,
                      width: 230,
                      decoration: const BoxDecoration(
                        color: Color(0xffFFE5D4),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 18,
            bottom: 15,
            left: 16,
            right: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Refer your friends",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 14),
                  InkWell(
                    onTap: () {
                      Share.share('https://restaurentpager.com/refer?code=${Get.find<UserController>().id}');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFED7B3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          "Refer now",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xffFC440E),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: SvgPicture.asset(
                    "assets/homeImages/referfriendimage.svg",
                  ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
