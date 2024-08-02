import 'dart:convert';
import 'package:flutter_fetch/src/models/ItemModel.dart';
import 'package:http/http.dart' show Client;

const _root = 'https://hacker-news.firebaseio.com/v0';

class NewsApiProvider {

  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_root/topstories.json' as Uri);
    final ids = json.decode(response.body);

    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_root/item/$id.json' as Uri);
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}
