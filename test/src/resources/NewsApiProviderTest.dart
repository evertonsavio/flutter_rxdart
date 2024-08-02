import 'dart:convert';
import 'package:flutter_fetch/src/models/ItemModel.dart';
import 'package:flutter_fetch/src/resources/NewsApiProvider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('FetchTopIds returns a list of ids', () async {
    // Create an instance of NewsApiProvider
    final newsApi = NewsApiProvider();

    // Mock the client
    newsApi.client = MockClient((request) async {
      return Response(json.encode([1, 2, 3, 4]), 200);
    });

    // Call fetchTopIds
    final ids = await newsApi.fetchTopIds();

    // Expect that ids is a list of integers
    expect(ids, [1, 2, 3, 4]);
    expect(ids, isA<List<dynamic>>());
  });

  test('FetchItem returns a item model', () async {
    // Create an instance of NewsApiProvider
    final newsApi = NewsApiProvider();

    // Mock the client
    newsApi.client = MockClient((request) async {
      // since I'm mocking just id, the other properties are null or empty
      // so you need to make sure that the ItemModel.fromJson handles null or empty values
      // add ? to the properties in ItemModel.dart otherwise this test will fail
      final jsonMap = {'id': 123};
      return Response(json.encode(jsonMap), 200);
    });

    // Call fetchItem
    final ItemModel item = await newsApi.fetchItem(123);

    // Expect that item is an ItemModel
    expect(item.id, 123);
    expect(item, isA<ItemModel>());
  });
}