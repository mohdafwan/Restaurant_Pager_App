import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:restuarant_pager_app/firebase/SocketClient/SocketClient.dart';
import 'package:restuarant_pager_app/models/OrderHistory/OrderModel.dart';

class OrderHistoryController extends GetxController {
  final dio.Dio _dio = dio.Dio();
  final _socket = SocketClient.instance;
  var isLoading = true.obs;
  var hasError = false.obs;
  var filtering = false.obs;
  var errorMessage = ''.obs;
  var resultMessage = ''.obs;
  var filteredOrders = <OrderModel>[].obs;
  var activeOrders = <OrderModel>[].obs;
  var completedOrders = <OrderModel>[].obs;
  var allOrders = <OrderModel>[].obs;
  final _userController = Get.find<UserController>();
  late TextEditingController _searchController;
  Map<int, OrderModel> orderMap = <int, OrderModel>{};
  var _selectedTags = <String>[].obs;

  // status
  final String ready = "order ready";
  final String going = "ongoing";
  final String completed = "completed";
  final String thisYear = DateFormat('yyyy').format(DateTime.now());
  final String last30Days = "Last 30 days";
  final String last6Months = "Last 6 Months";

  // dummy data
List<OrderModel> dummyData = [
  OrderModel(
    id: 1992,
    customerName: "test User",
    billId: 5465132,
    orderDate: "10-10-24",
    deliveryData: "6:00 PM",
    amount: 555,
    note: "",
    tag: [],
    orderStatus: "ongoing",
    imgUrl: "https://lofrev.net/wp-content/photos/2016/06/KFC_logo_1.png",
    restaurantName: "KFC",
    address: "Pacific Mall Delhi",
    user: 121,
    restaurant: 1,
  ),
  OrderModel(
    id: 1993,
    customerName: "John Doe",
    billId: 987654,
    orderDate: "15-10-24",
    deliveryData: "7:00 PM",
    amount: 700,
    note: "Extra cheese",
    tag: [],
    orderStatus: "order ready",
    imgUrl: "https://1000logos.net/wp-content/uploads/2017/05/Pizza-Hut-Logo.png",
    restaurantName: "Pizza Hut",
    address: "City Center Mall, Mumbai",
    user: 122,
    restaurant: 2,
  ),
  OrderModel(
    id: 1994,
    customerName: "Jane Smith",
    billId: 123456,
    orderDate: "20-10-24",
    deliveryData: "8:00 PM",
    amount: 850,
    note: "No onions",
    tag: [],
    orderStatus: "completed",
    imgUrl: "https://logowik.com/content/uploads/images/burger-king-new-20218389.jpg",
    restaurantName: "Burger King",
    address: "DLF Cyber Hub, Gurgaon",
    user: 123,
    restaurant: 3,
  ),
];


  @override
  void onInit() {
    super.onInit();
    _searchController = TextEditingController();
    // search order
    _searchController.addListener(() {
      if (_searchController.text.isNotEmpty) {
        filtering(true);
        List<OrderModel> temp = allOrders
            .where((model) => model.restaurantName
                .toLowerCase()
                .startsWith(_searchController.text.toLowerCase()))
            .toList();
        filteredOrders.value = temp;
        if (temp.isEmpty) {
          errorMessage.value = "No Results Found";
        } else {
          resultMessage.value = "${filteredOrders.length} Results Found";
        }
      } else {
        filtering(false);
        filteredOrders.value = <OrderModel>[];
        resultMessage.value = '';
      }
    });
    // socket
    _socket.listen((data) {
      if (kDebugMode) {
        print("data received : $data");
      }
      OrderModel model = OrderModel.fromJson(data);
      switch (data['type']) {
        case 'new':
          orderMap[model.id] = model;
          allOrders.insert(0, model);
          activeOrders.insert(0, model);
          break;

        case 'updated':
          orderMap[model.id] = model;
          splitOrders();
          break;
      }
    });
    // listen filter
    _selectedTags.listen((current) {
      if (current.isNotEmpty && allOrders.isNotEmpty) {
        filtering(true);
        List<OrderModel> temp = allOrders;
        // first filter on basis of status
        if (current.contains(ready) ||
            current.contains(going) ||
            current.contains(completed)) {
          temp = temp.where((order) {
            return _selectedTags.contains(order.orderStatus);
          }).toList();
        }

        // filter on the basis of dates
        final now = DateTime.now();
        DateTime sixMonthsAgo = now.subtract(const Duration(days: 180));
        DateTime thirtyDaysAgo = now.subtract(const Duration(days: 30));
        if (current.contains(thisYear)) {
          // Filter orders for this year
          temp = temp.where((order) {
            DateTime parsedDate = DateFormat('dd-MM-yy').parse(order.orderDate);
            return DateFormat('yyyy').format(parsedDate) == thisYear;
          }).toList();
        } else if (current.contains(last6Months)) {
          // Filter orders from the last 6 months
          temp = temp.where((order) {
            DateTime parsedDate = DateFormat('dd-MM-yy').parse(order.orderDate);
            return parsedDate.isAfter(sixMonthsAgo) && parsedDate.isBefore(now);
          }).toList();
        } else if (current.contains(last30Days)) {
          // Filter orders from the last 30 days
          temp = temp.where((order) {
            DateTime parsedDate = DateFormat('dd-MM-yy').parse(order.orderDate);
            return parsedDate.isAfter(thirtyDaysAgo) &&
                parsedDate.isBefore(now);
          }).toList();
        }

        filteredOrders.value = temp;
        if (temp.isEmpty) {
          errorMessage.value = "No Results Found";
        } else {
          resultMessage.value = "${filteredOrders.length} Results Found";
        }
      } else {
        filteredOrders.value = <OrderModel>[];
        filtering(false);
        resultMessage.value = '';
      }
    });

    fetchOrderHistory();
  }

  //getters
  TextEditingController get search => _searchController;
  List<String> get selectedTags => _selectedTags;
  int get completedCount => allOrders.where((order) => order.orderStatus == completed).length;

  //setters
  set selectedTags(List<String> tags) {
    _selectedTags.value = tags;
  }

  // Simulate fetching order history data
  void fetchOrderHistory() async {
    try {
      isLoading(true);
      hasError(false);

      final response = await _dio.post(
        "$host/order_history/",
        data: {
          "id": _userController.id,
        },
        options: dio.Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode != 200) {
        hasError(true);
        return;
      }
      if (kDebugMode) {
        print("response : ${response.data}");
      }

      if (response.data != null) {
        List<Map<String, dynamic>> data =
            List<Map<String, dynamic>>.from(response.data);
        allOrders.value = data.map((entry) {
          OrderModel model = OrderModel.fromJson(entry);
          orderMap[model.id] = model;
          return model;
        }).toList();
        allOrders.value = dummyData;
        filteredOrders.value = allOrders; // initially
        splitOrders();
      }
      if (allOrders.isEmpty) {
        errorMessage.value = "No orders Found";
      }
    } catch (e) {
      if (kDebugMode) {
        print("error :  $e");
      }
      errorMessage.value = "Error Loading Orders";
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  void arrange() {
    Map<String, int> priority = {
      ready: 1,
      going: 2,
      completed: 3,
    };
    allOrders.sort((a, b) {
      return priority[a.orderStatus]!.compareTo(priority[b.orderStatus]!);
    });
  }

  void splitOrders(){
    var activeOrderTemp = <OrderModel>[];
    var completedOrderTemp = <OrderModel>[];
    arrange();
    for(OrderModel order in allOrders){
      if(order.orderStatus == completed){
        completedOrderTemp.add(order);
      }else{
        activeOrderTemp.add(order);
      }
    }
    activeOrders.value = activeOrderTemp;
    completedOrders.value = completedOrderTemp;
  }
}
