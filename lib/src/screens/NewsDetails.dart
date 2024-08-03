import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  const NewsDetails({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Text('Details $itemId'),
    );
  }
}
