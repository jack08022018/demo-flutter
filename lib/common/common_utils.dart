import 'package:flutter/material.dart';
import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'app_errors.dart';

// Utility function to display a simple error dialog
void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


void showError(String errorMessage) {
  Fluttertoast.showToast(
      msg: errorMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      webBgColor: "linear-gradient(to right, #b00f00, #b06f00)",
      fontSize: 16.0);
}

Future<Either<CommonError, http.Response>> callApi(Future<http.Response> request) async {
  try {
    return Right(await request);
  } catch (e) {
    return Left(CommonError(message: "Request executing with errors: $e"));
  }
}

Either<CommonError, http.Response> checkHttpStatus(http.Response response) {
  if (response.statusCode == 200) return Right(response);
  if (response.statusCode >= 500) {
    return Left(CommonError(
        message: "Server error with http status ${response.statusCode}"));
  }
  return Left(CommonError(message: "Bad http status ${response.statusCode}"));
}

Future<Either<CommonError, dynamic>> parseJson(http.Response response) async {
  try {
    final jsonResult = jsonDecode(response.body);
    return Right(jsonResult);
  } catch (e) {
    return Left(CommonError(message: 'failed on JSON parsing'));
  }
}