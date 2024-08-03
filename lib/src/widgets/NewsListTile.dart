import 'package:flutter/material.dart';

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
            return const Center(child: CircularProgressIndicator());
          }

          return FutureBuilder(
              future: snapshot.data?[itemId],
              builder: (BuildContext context, AsyncSnapshot<ItemModel?> itemSnapshot) {
                if (!itemSnapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListTile(
                    title: Text(itemSnapshot.data!.title?? 'No title'),
                    subtitle: Text('${itemSnapshot.data!.score} points'),
                    trailing: Column(
                        children: <Widget>[
                          const Icon(Icons.comment),
                          Text('${itemSnapshot.data!.descendants}'),
                        ],
                    ),
                );
              },
          );
        },
    );
  }
}
