// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../controllers/notification/notification_settrings_controller.dart';

// class SettingsPage extends StatelessWidget {
//   final NotificationSettingsController controller =
//       Get.find<NotificationSettingsController>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Notification Settings'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Obx(
//               () => SwitchListTile(
//                 title: const Text('Vibration'),
//                 value: controller.vibrationEnabled.value,
//                 onChanged: controller.toggleVibration,
//               ),
//             ),
//             Obx(
//               () => SwitchListTile(
//                 title: const Text('Sound'),
//                 value: controller.soundEnabled.value,
//                 onChanged: controller.toggleSound,
//               ),
//             ),
//             Obx(
//               () => SwitchListTile(
//                 title: const Text('Flash Light'),
//                 value: controller.flashLightEnabled.value,
//                 onChanged: controller.toggleFlashLight,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
