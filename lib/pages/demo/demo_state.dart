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
    Future<Either<CommonError, Response>> excuteApi() async {
      try {
        Map<String, dynamic> requestBody = {
          'username': 'king',
        };
        var bodyEncode = jsonEncode(requestBody);
        var response = await post(
          Uri.http('localhost:9195', '/demo/api/getStaffList'),
          headers: {'Content-Type': 'application/json'},
          body: bodyEncode,
        );
        return Right(response);
      } on Exception catch (e) {
        return Left(
            CommonError(message: 'Failed on excuteApi: ${e.toString()}'));
      }
    }

    return excuteApi()
        .thenRight(checkHttpStatus)
        .thenRight(parseJson)
        .fold(
          (left) => showError(left.message), 
          (right) {
            // print('AAA: $right');
            staffList = right;
            // notifyListeners();

            Either<String, int> result = divide(10, 0);
            result.fold((l) => print("LEFT: $l"), (r) => print("RIGHT: $r"));
          }
        );
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
