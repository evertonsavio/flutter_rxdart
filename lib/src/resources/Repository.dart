import 'package:flutter_fetch/src/models/ItemModel.dart';
import 'package:flutter_fetch/src/resources/NewsApiProvider.dart';
import 'package:flutter_fetch/src/resources/NewsDbaProvider.dart';

class Repository {
  List<Source> sources = <Source>[
    NewsApiProvider(),
    newsDbaProvider,
  ];
  List<Cache> caches = <Cache>[
    newsDbaProvider,
  ];

  Future<List<int>> fetchTopIds() {
    // TODO - implement fetchTopIds for newsDbaProvider
    return sources[1].fetchTopIds();
  }

  Future<ItemModel?> fetchItem(int id) async {
    ItemModel? item;
    Source source;

    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null) {
        break;
      }
    }

    for (var cache in caches) {
      if (item != null) {
        cache.addItem(item);
      }
    }

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel?> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}
