import 'package:flutter/material.dart';
import 'package:flutter_fetch/src/widgets/NewsListTile.dart';

import '../blocs/StoriesProvider.dart';
import '../widgets/Refresh.dart';

class NewsList extends StatelessWidget {
  const NewsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    // BAD!!! TEMPORARY!!!
    bloc.fetchTopIds();

    return Scaffold(
      appBar: AppBar(title: const Text('Top News')),
      body: buildList(bloc),
    );
  }

  Widget buildList(StoriesBloc bloc) {
    return StreamBuilder(
      stream: bloc.topIdsStream,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              bloc.fetchItem(snapshot.data![index]);

              return NewsLisTile(itemId: snapshot.data![index]);
            },
          ),
        );
      },
    );
  }
}
