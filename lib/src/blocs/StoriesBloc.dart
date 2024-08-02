import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../models/ItemModel.dart';
import '../resources/Repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIdsController = PublishSubject<List<int>>();
  final _itemsOutputController = BehaviorSubject<int>();
  late Stream<Map<int, Future<ItemModel?>>> itemsStream;

  StoriesBloc() {
    itemsStream = _itemsOutputController.stream.transform(_itemsTransformer());
  }

  //Streams
  Stream<List<int>> get topIdsStream => _topIdsController.stream;
  Stream<Map<int, Future<ItemModel?>>> get transformedItemsStream => itemsStream;

  // Sinks
  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIdsController.sink.add(ids);
  }
  Function(int) get fetchItem => _itemsOutputController.sink.add;

  //Transformers
  _itemsTransformer() {
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel?>>cache, int id, index) {
          cache[id] = _repository.fetchItem(id);
          return cache;
        },
        <int, Future<ItemModel?>>{},
    );
  }
  
  //Clean up
  dispose() {
    _topIdsController.close();
    _itemsOutputController.close();
  }
}
