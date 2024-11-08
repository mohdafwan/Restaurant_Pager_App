import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({super.key});

  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      padding: const EdgeInsets.all(16.0),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userController.name ?? "Name",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff1E1E1E),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  userController.email ?? "Email",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff1E1E1E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userController.id?.toString() ?? "ID",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff1E1E1E),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          userController.profilePic == null
              ? SvgPicture.asset(
                  "assets/homeImages/avatars.svg",
                  width: 60,
                  height: 60,
                )
              : CircleAvatar(
                  radius: 30,
                  foregroundImage: AssetImage(userController.profilePic!),
                ),
        ],
      ),
    );
  }
}
