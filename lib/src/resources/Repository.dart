import 'package:flutter_fetch/src/models/ItemModel.dart';
import 'package:flutter_fetch/src/resources/NewsApiProvider.dart';
import 'package:flutter_fetch/src/resources/NewsDbaProvider.dart';

class Repository {

  NewsDbaProvider dbaProvider = NewsDbaProvider();
  NewsApiProvider apiProvider = NewsApiProvider();

  Future<List<int>> fetchTopIds() {
    return apiProvider.fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    var item = await dbaProvider.fetchItem(id);
    if (item != null) {
      return item;
    }
    item = await apiProvider.fetchItem(id);
    dbaProvider.addItem(item);
    return item;
  }
}
