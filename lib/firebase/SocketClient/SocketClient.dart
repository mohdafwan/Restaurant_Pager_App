import 'dart:convert';
import 'package:get/get.dart';
import 'package:restuarant_pager_app/controllers/UserController/UserController.dart';
import 'package:restuarant_pager_app/firebase/AuthMethods/AuthMethods.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketClient {
  late WebSocketChannel _channel;
  static SocketClient? _instance;
  final userController = Get.find<UserController>();

  SocketClient._internal() {
    _channel = WebSocketChannel.connect(
      Uri.parse("$wsHost/ws/order/"),
    );
    
    final data = {
      'userId': userController.id,
    };

    _channel.sink.add(jsonEncode(data));
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }

  void listen(Function(dynamic) func) {
    _channel.stream.listen((message) {
      final data = jsonDecode(message);
      func(data);
    });
  }

  void close() {
    _channel.sink.close();
  }
}
