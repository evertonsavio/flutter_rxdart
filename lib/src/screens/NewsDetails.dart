import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_fetch/src/models/ItemModel.dart';
import '../blocs/CommentsProvider.dart';

class NewsDetails extends StatelessWidget {
  final int itemId;

  const NewsDetails({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final commentsBloc = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: buildBody(commentsBloc),
    );
  }

  Widget buildBody(CommentsBloc bloc) {
    return StreamBuilder(
      stream: bloc.itemWithComments,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }

        final itemFuture = snapshot.data?[itemId];

        return FutureBuilder(
          future: itemFuture,
          builder: (context, itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return Text('Loading');
            }

            return Text('${itemSnapshot.data?.title}');
          },
        );
      },
    );
  }

/*  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {
    final children = <Widget>[];
    children.add(buildTitle(item));
    final commentsList = item.kids.map((kidId) {
      return Comment(itemId: kidId, itemMap: itemMap, depth: 0);
    }).toList();
    children.addAll(commentsList);

    return ListView(
      children: children,
    );
  }*/

/*  Widget buildTitle(ItemModel item) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        item.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }*/
}
