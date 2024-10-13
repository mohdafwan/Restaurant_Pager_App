import 'package:get/get.dart';

class NotificationsSettingsController extends GetxController {
  RxBool orderReadyAlerts = false.obs;
  RxBool vibrationAlerts = false.obs;
  RxBool flashlightAlerts = false.obs;
}