import 'package:get/get.dart';
// import 'package:restuarant_pager_app/controllers/dashboard_controller/dashboard_controller.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/OrderHistoryController/OrderHistoryController.dart';
import 'package:restuarant_pager_app/controllers/pages_controller/home_controller/home_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
     // i have moved it to main function
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<OrderHistoryController>(() => OrderHistoryController());
  }
}
