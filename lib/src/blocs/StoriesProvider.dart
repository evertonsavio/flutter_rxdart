import 'package:flutter/material.dart';
import 'StoriesBloc.dart';
export 'StoriesBloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc bloc;

  StoriesProvider({super.key, required super.child})
      : bloc = StoriesBloc();

  static StoriesBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<StoriesProvider>() as StoriesProvider).bloc;
  }

  @override
  bool updateShouldNotify(StoriesProvider oldWidget) {
    return true;
  }
}
