import 'package:flutter/material.dart';

class DemoState extends ChangeNotifier {
  var staffList = [
    {"name": "Sarah", "age": "19", "role": "Student"},
    {"name": "Janine", "age": "43", "role": "Professor"},
    {"name": "William", "age": "27", "role": "Associate Professor"},
  ];

  GlobalKey? historyListKey;

  void addItem(item) {
    staffList.add(item);
    notifyListeners();
  }
}
