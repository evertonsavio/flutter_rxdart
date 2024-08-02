import 'package:flutter/material.dart';
import 'package:flutter_fetch/src/screens/NewsList.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'News!',
      home: Newslist(),
    );
  }
}
