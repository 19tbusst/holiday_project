import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:holiday_project/app_state.dart';
import 'package:holiday_project/collection.dart';
import 'package:holiday_project/display.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isCollecting = true;

  void _toggleScreen() {
    setState(() {
      _isCollecting = !_isCollecting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holiday Project',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(_isCollecting
              ? 'Collecting Person Data'
              : 'Displaying Person Data'),
          centerTitle: true,
        ),
        body: Center(
          child: SizedBox(
            width: 500,
            child: _isCollecting ? const Collection() : const Display(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleScreen,
          child: Icon(
              _isCollecting ? Icons.group_rounded : Icons.group_add_rounded),
        ),
      ),
    );
  }
}
