import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restuarant_pager_app/controllers/notification/notification_controller.dart';

class NotificationsSettingsPage extends StatelessWidget {
  NotificationsSettingsPage({super.key});
  final NotificationsSettingsController controller =
      Get.put(NotificationsSettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, color: const Color(0xff090A0A)),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 34),
          height: 40,
          width: 40,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            splashColor: Colors.grey,
            child: Image.asset(
              'assets/images/backarrow.png',
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Options to enable/disable vibrations, sounds, and flashlight alerts for notifications.',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: const Color(0xff141C24),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25.0),
            Obx(() => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffF7F9FA),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/notification_bell.png'),
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                    title: Text('Order Ready Alerts',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff090A0A))),
                    subtitle: Text(
                      'Receive notification when an order is ready',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff141C24),
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: controller.orderReadyAlerts.value,
                      onChanged: (value) {
                        controller.orderReadyAlerts.value = value;
                      },
                      activeColor: const Color.fromARGB(255, 187, 211, 253),
                    ),
                  ),
                )),
            const SizedBox(height: 25.0),
            Obx(() => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffF7F9FA),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/notification_bell.png'),
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                    title: Text('Vibration Alerts',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff090A0A))),
                    subtitle: Text(
                      'Enable Vibrations for notification',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff141C24),
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: controller.vibrationAlerts.value,
                      onChanged: (value) {
                        controller.vibrationAlerts.value = value;
                      },
                      activeColor: const Color.fromARGB(255, 187, 211, 253),
                    ),
                  ),
                )),
            const SizedBox(height: 25.0),
            Obx(() => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xffF7F9FA),
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/notification_bell.png'),
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                    title: Text('Flashlight Alerts',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff090A0A))),
                    subtitle: Text(
                      'Enable Flashlight alerts for notification',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff141C24),
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: controller.flashlightAlerts.value,
                      onChanged: (value) {
                        controller.flashlightAlerts.value = value;
                      },
                      activeColor: const Color.fromARGB(255, 187, 211, 253),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
