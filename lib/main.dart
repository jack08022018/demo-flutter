import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layouts/main_layout_state.dart';
import 'layouts/main_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainLayoutState(),
      child: MaterialApp(
        title: 'Name App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MainLayout(),
      ),
    );
  }
}
