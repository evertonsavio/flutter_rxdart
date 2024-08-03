import 'package:flutter/material.dart';
import 'package:flutter_fetch/src/blocs/CommentsProvider.dart';
import 'package:flutter_fetch/src/blocs/StoriesProvider.dart';
import 'package:flutter_fetch/src/screens/NewsDetails.dart';
import 'package:flutter_fetch/src/screens/NewsList.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

    return CommentsProvider(
        child: StoriesProvider(
          child: MaterialApp(
            title: 'News!',
            onGenerateRoute: routes,
          ),
        ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (BuildContext context) {

          return const NewsList();
        },
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) {
          final commentsBloc = CommentsProvider.of(context);
          final itemId = int.parse(settings.name!.replaceFirst('/', ''));
          // Initialization, best place probably
          commentsBloc.fetchItemWithComments(itemId);

          return NewsDetails(
            itemId: itemId,
          );
        },
      );
    }
  }
}
