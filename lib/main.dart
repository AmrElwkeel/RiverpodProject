import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/src/data/data_source/shared_preferences/shared_preferences.dart';
import 'package:riverpod_project/src/pages/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesHelperImpl().init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
