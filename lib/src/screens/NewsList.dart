import 'package:flutter/material.dart';

import '../blocs/StoriesProvider.dart';

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

        return ListView.builder(
          itemCount: snapshot.data?.length,
          itemBuilder: (BuildContext context, int index) {
            return Text('${snapshot.data![index]}');
          },
        );
      },
    );
  }
}
