import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class DemoState extends ChangeNotifier {
  List<dynamic> staffList = <dynamic>[];

  GlobalKey? historyListKey;

  Future<void> getStaffList() async {
    try {
      Response response = await post(Uri.http('localhost:9195', '/demo/api/getStaffList'));
      // print(response.body);
      staffList = jsonDecode(response.body);
    } catch (e) {
      print('Caught error: $e');
    }
    notifyListeners();
  }

  // Future<void> getStaffList() async {
  //   try {
  //     final dio = Dio();
  //     final response = await dio.post('http://localhost:9195/demo/api/getStaffList');
  //     print(response.data);
  //   } catch (e) {
  //     print('Caught error: $e');
  //   }
  // }

  void addItem(item) {
    staffList.add(item);
    notifyListeners();
  }
}
