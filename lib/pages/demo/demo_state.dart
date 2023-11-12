import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:either_dart/either.dart';
import 'dart:convert';
import '../../common/app_errors.dart';
import '../../common/common_utils.dart';
// import 'test.dart';

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

  Future<void> getStaffListNew() {
    Future<Either<CommonError, String>> getBody() async {
      try {
        Map<String, dynamic> requestBody = {
          'username': 'king',
        };
        return Right(jsonEncode(requestBody));
      } on Exception catch (e) {
        return Left(CommonError(message: 'Error in getStaffList getBody: ${e.toString()}'));
      }
    }

    return getBody()
        .thenRight((body) => postApi('/demo/api/getStaffList', body))
        .fold(
          (e) => null, 
          (right) {
            staffList = right;
            notifyListeners();
          });
  }

  void testEither() {
    const List<int> list = [1, 2, 3, 4];
    print("sum all: ${list.fold<int>(0, (p, c) => p + c)}");
    print(
        "sum e > 2: ${list.where((e) => e > 2).fold<int>(0, (p, c) => p + c)}");
  }

  Either<String, int> divide(int dividend, int divisor) {
    if (divisor == 0) {
      return Left('Cannot divide by zero');
    } else {
      return Right(dividend ~/ divisor);
    }
  }

  // Store<TodoList> todoList = Store(TodoList([]));
  // todoList.apply(addTodoItem(1, "buy xmas gifts"));
  // todoList.apply(completeItem(1));
}
