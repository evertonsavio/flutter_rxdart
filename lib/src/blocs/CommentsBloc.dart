import 'dart:async';
import 'package:flutter_fetch/src/models/ItemModel.dart';
import 'package:rxdart/rxdart.dart';
import '../resources/Repository.dart';

class CommentsBloc {
  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel?>>>();

  // Constructor
  CommentsBloc() {
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  // Streams
  Stream<Map<int, Future<ItemModel?>>> get itemWithComments => _commentsOutput.stream;

  // Sink
  Function(int) get fetchItemWithComments => _commentsFetcher.sink.add;

  // Transformer
  _commentsTransformer() {
    return ScanStreamTransformer<int, Map<int, Future<ItemModel?>>>((cache, int id, index) {
        cache[id] = _repository.fetchItem(id);
        cache[id]?.then((ItemModel? item) {
          item?.kids?.forEach((kidId) => fetchItemWithComments(kidId));
        });

        return cache;
      },
      <int, Future<ItemModel?>>{},
    );
  }

  dispose() {
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}