import 'package:flutter/material.dart';
import 'package:flutter_fetch/src/blocs/StoriesProvider.dart';
import 'package:flutter_fetch/src/screens/NewsList.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
          title: 'News!',
          home: NewsList(),
        ),
    );
  }
}
