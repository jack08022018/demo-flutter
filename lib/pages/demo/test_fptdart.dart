import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
// import 'test.dart';

class DemoState extends ChangeNotifier {
  Future<void> callApi() async {
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
      print('AAA: $response');
    } on Exception catch (e) {
      print('AAA: $e');
    }
  }

  // Future<Either<Exception, String>> callApiFptdart() async {
  //   return await Either<Exception, String>.tryCatch(() async {
  //     final requestBody = {'username': 'king'};
  //     final bodyEncode = jsonEncode(requestBody);

  //     final response = await post(
  //       Uri.parse('http://localhost:9195/demo/api/getStaffList'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: bodyEncode,
  //     );

  //     return response;
  //   });
  // }

}
