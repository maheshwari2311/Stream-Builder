import 'dart:async';

import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      _streamController.sink.add(_counter++);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stream Builder",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _streamController.stream,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError) {
              return Text('Error : ${snapshot.error}');
            }
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text(
                  'select lot',
                );
              case ConnectionState.waiting:
                return const Text(
                  "awaiting bids.......",
                );
              case ConnectionState.active:
                return Text('current count : ${snapshot.data}');
              case ConnectionState.done:
                return const Text(
                  "stream closed",
                );
            }
          },
        ),
      ),
    );
  }
}
