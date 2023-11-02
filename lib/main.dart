import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
// import 'package:time_app/reducer.dart';

// import 'app_state.dart';
// import 'middleware.dart';

import 'components/my_app_state.dart';
import 'components/my_home_page.dart';

void main() {
  runApp(MyApp());
}

typedef FetchTime = void Function();

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  // final store = Store<AppState>(reducer,
  //     initialState: AppState.initialState(),
  //     middleware: [thunkMiddleware]);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Name App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}
