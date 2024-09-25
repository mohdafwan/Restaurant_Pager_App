import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/notification/notification_settings_controller.dart';


class SettingsPage extends StatelessWidget {
  final NotificationSettingsController controller =
      Get.find<NotificationSettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => SwitchListTile(
                  title: Text('Vibration'),
                  value: controller.vibrationEnabled.value,
                  onChanged: controller.toggleVibration,
                )),
            Obx(() => SwitchListTile(
                  title: Text('Sound'),
                  value: controller.soundEnabled.value,
                  onChanged: controller.toggleSound,
                )),
            Obx(() => SwitchListTile(
              
                  title: Text('Flash Light'),
                  value: controller.flashLightEnabled.value,
                  onChanged: controller.toggleFlashLight,
                )),
          ],
        ),
      ),
    );
  }
}
