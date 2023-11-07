import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../../common/app_errors.dart';
import '../../common/common_utils.dart';
import 'package:either_dart/either.dart';

class DemoState extends ChangeNotifier {
  List<dynamic> staffList = <dynamic>[];

  GlobalKey? historyListKey;

  Future<void> getStaffList() async {
    try {
      Map<String, dynamic> requestBody = {
        'username': 'king',
      };
      Response response = await post(
          Uri.http('localhost:9195', '/demo/api/getStaffList'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody));
      print(response.body);
      if (response.body.isNotEmpty) {
        throw CommonError(message: 'custom error!');
      }
      staffList = jsonDecode(response.body);
    } on CommonError catch (e) {
      print("Error: ${e.message}");
      showError(e.message);
    } on Exception catch (e) {
      print("Error: ${e.toString()}");
      showError(e.toString());
    }
    // notifyListeners();
  }

  Future<void> getDataFromServer() {
    Map<String, dynamic> requestBody = {
      'username': 'king',
    };
    var response = post(
        Uri.http('localhost:9195', '/demo/api/getStaffList'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody));
    return callApi(response)
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .fold(
          (left) => showError(left.message), 
          (right) {
            print('AAA: $right');
            staffList = right;
            notifyListeners();
          });
  }
}
