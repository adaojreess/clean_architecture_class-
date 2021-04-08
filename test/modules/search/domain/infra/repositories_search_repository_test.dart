import 'package:clean_architecture_class/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_class/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_class/modules/search/infra/datasource/search_datasouce.dart';
import 'package:clean_architecture_class/modules/search/infra/models/result_search_model.dart';
import 'package:clean_architecture_class/modules/search/infra/respositories/search_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchDatasourceMock extends Mock implements SearchDatasource {}

main() {
  final datasource = SearchDatasourceMock();
  final repository = SearchRepositoryImpl(datasource);
  test('> Deve retornar uma lista de ResultSearch', () async {
    when(datasource.getSearch(any))
        .thenAnswer((_) async => <ResultSearchModel>[]);

    final result = await repository.search('adao');

    expect(result | null, isA<List<ResultSearch>>());
  });

  test('> Deve retornar um DataSourceError se o datasource falha', () async {
    when(datasource.getSearch(any)).thenThrow(Exception());

    final result = await repository.search('adao');

    expect(result.fold(id, id), isA<DataSourceError>());
  });
}
