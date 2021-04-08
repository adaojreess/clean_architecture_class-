import 'dart:convert';

import 'package:clean_architecture_class/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_class/modules/search/external/datasources/github_datasource.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_result.dart';

class DioMock extends Mock implements Dio {}

main() {
  final dio = DioMock();
  final datasource = GithubDataSource(dio);
  test('> Deve retornar uma lista de ResultSearchModel', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
          data: jsonDecode(githubResult),
          statusCode: 200,
          requestOptions: null,
        ));

    final futureResult = datasource.getSearch('searchText');
    expect(futureResult, completes);
  });

  test('> Deve retornar uma DatasourceError se o código nao for 200', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
          data: null,
          statusCode: 401,
          requestOptions: null,
        ));

    final futureResult = datasource.getSearch('searchText');
    expect(futureResult, throwsA(isA<DataSourceError>()));
  });

  test('> Deve retornar uma Exception se tiver um erro no dio', () async {
    when(dio.get(any)).thenThrow(Exception());

    final futureResult = datasource.getSearch('searchText');
    expect(futureResult, throwsA(isA<Exception>()));
  });
}
