import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './components/datatable_example.dart';
import './demo_state.dart';
import '../../layouts/main_layout_state.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var demoState = context.watch<DemoState>();
    var appState = context.watch<MainLayoutState>();
    var pair = appState.current;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          DataTableExample(),
          ElevatedButton(
            onPressed: () {
              demoState.getStaffList();
              // demoState.addItem({
              //   "name": pair.toString(),
              //   "age": "27",
              //   "role": "Associate Professor"
              // });
            },
            child: Text('Add'),
          )
        ]
      )
    );
  }
}
