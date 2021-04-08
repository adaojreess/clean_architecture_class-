import 'package:clean_architecture_class/modules/search/domain/errors/errors.dart';

import '../../../domain/entities/result_search.dart';

abstract class SearchState {}

class SearchSuccess implements SearchState {
  final List<ResultSearch> list;

  SearchSuccess(this.list);
}

class SearchStart implements SearchState {}

class SearchLoading implements SearchState {}

class SearchError implements SearchState {
  final FailureSearch error;

  SearchError(this.error);
}
