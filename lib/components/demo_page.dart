import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import './my_app_state.dart';
import './datatable_example.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    // var appState = context.watch<MyAppState>();

    return Center(
      child: DataTableExample(),
    );
  }
}
