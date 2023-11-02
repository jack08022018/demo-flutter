import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../demo_state.dart';

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    var demoState = context.watch<DemoState>();

    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: List.generate(
          demoState.staffList.length,
          (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text(demoState.staffList[index]["name"] ?? "")),
                  DataCell(Text(demoState.staffList[index]["age"] ?? "")),
                  DataCell(Text(demoState.staffList[index]["role"] ?? "")),
                ],
              )),
    );
  }
}
