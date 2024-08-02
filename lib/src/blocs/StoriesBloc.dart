import 'package:rxdart/rxdart.dart';

import '../resources/Repository.dart';

class StoriesBloc {
  final _repository = Repository();
  final _topIdsController = PublishSubject<List<int>>();

  Stream<List<int>> get topIds => _topIdsController.stream;

  fetchTopIds() async {
    final ids = await _repository.fetchTopIds();
    _topIdsController.sink.add(ids);
  }

  dispose() {
    _topIdsController.close();
  }
}
