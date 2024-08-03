import 'package:flutter/material.dart';
import 'CommentsBloc.dart';
export 'CommentsBloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;

  CommentsProvider({super.key, required super.child})
      : bloc = CommentsBloc();

  static CommentsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<CommentsProvider>() as CommentsProvider).bloc;
  }

  @override
  bool updateShouldNotify(CommentsProvider oldWidget) {
    return true;
  }
}
