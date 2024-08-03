import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/ItemModel.dart';
import '../resources/Repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIdsController = PublishSubject<List<int>>();
  final _itemsFetcher = PublishSubject<int>();
  final _itemsOutputController = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  // Constructor
  StoriesBloc() {
    _itemsFetcher.stream.transform(_itemsTransformer()).pipe(_itemsOutputController);
  }

  // Streams
  Stream<List<int>> get topIdsStream => _topIdsController.stream;
  Stream<Map<int, Future<ItemModel?>>> get itemsStream => _itemsOutputController.stream;

  // Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIdsController.sink.add(ids);
  }

  // Transformers
  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel?>>cache, int id, index) {
          cache[id] = _repository.fetchItem(id);
          return cache;
        },
        <int, Future<ItemModel?>>{},
    );
  }

  // Clean up
  dispose() {
    _topIdsController.close();
    _itemsFetcher.close();
    _itemsOutputController.close();
  }
}
