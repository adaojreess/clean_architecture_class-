import 'package:clean_architecture_class/modules/search/domain/errors/errors.dart';
import 'package:dio/dio.dart';

import '../../infra/datasource/search_datasouce.dart';
import '../../infra/models/result_search_model.dart';

extension on String {
  String get normalize {
    return replaceAll(' ', '+');
  }
}

class GithubDataSource implements SearchDatasource {
  final Dio dio;

  GithubDataSource(this.dio);
  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio
        .get('https://api.github.com/search/users?q=${searchText.normalize}');

    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList();

      return list;
    } else {
      throw DataSourceError();
    }
  }
}
