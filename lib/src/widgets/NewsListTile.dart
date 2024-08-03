import 'package:flutter/material.dart';
import 'package:flutter_fetch/src/widgets/LoadingContainer.dart';

import '../blocs/StoriesProvider.dart';
import '../models/ItemModel.dart';

class NewsLisTile extends StatelessWidget {
  final int itemId;

  const NewsLisTile({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
        stream: bloc.itemsStream,
        builder: (BuildContext context, AsyncSnapshot<Map<int, Future<ItemModel?>>> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingContainer();
          }

          return FutureBuilder(
              future: snapshot.data?[itemId],
              builder: (BuildContext context, AsyncSnapshot<ItemModel?> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return const LoadingContainer();
                }

                return buildTitle(itemSnapshot.data!);
              },
          );
        },
    );
  }

  Widget buildTitle(ItemModel item) {
    return Column(
      children: [
        ListTile(
          title: Text(item.title?? 'No title'),
          subtitle: Text('${item.score} points'),
          trailing: Column(
            children: <Widget>[
              const Icon(Icons.comment),
              Text('${item.descendants}'),
            ],
          ),
        ),
        const Divider(height: 8.0)
      ],
    );
  }
}
