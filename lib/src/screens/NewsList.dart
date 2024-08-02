import 'package:flutter/material.dart';

class Newslist extends StatelessWidget {
  const Newslist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top News')),
      body: const Text('Show a list of news here'),
    );
  }
}
