import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'app_errors.dart';

Future<void> showError(String errorMessage) {
  return Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      webBgColor: "linear-gradient(to right, #b00f00, #b06f00)",
      fontSize: 16.0);
}

Either<CommonError, Response> checkHttpStatus(Response response) {
  if (response.statusCode == 200) return Right(response);
  
  print("Http status: ${response.statusCode} body: ${response.body}");
  if (response.statusCode >= 500) {
    return Left(CommonError(message: "Server error with http status ${response.statusCode}"));
  }
  return Left(CommonError(message: "Bad http status ${response.statusCode}"));
}

Either<CommonError, dynamic> parseJson(Response response) {
  try {
    final jsonResult = jsonDecode(response.body);
    // print(10 ~/ 0);
    return Right(jsonResult);
  } catch (e) {
    return Left(CommonError(message: 'failed on JSON parsing'));
  }
}

Future<Either<CommonError, dynamic>> postApi(String url, Object bodyEncode) async {
  Future<Either<CommonError, Response>> excuteApi() async {
    try {
      var response = await post(
        Uri.http('localhost:9195', url),
        headers: {'Content-Type': 'application/json'},
        body: bodyEncode,
      );
      return Right(response);
    } on Exception catch (e) {
      return Left(CommonError(message: 'Failed on excuteApi: ${e.toString()}'));
    }
  }

  return excuteApi()
    .thenRight(checkHttpStatus)
    .thenRight(parseJson)
    .fold(
      (e) {
        showError(e.message);
        throw e;
      }, 
      (right) {
        return Right(right);
      }
    );
}