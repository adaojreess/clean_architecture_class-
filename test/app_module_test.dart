import 'dart:convert';

import 'package:clean_architecture_class/modules/app_module.dart';
import 'package:clean_architecture_class/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_class/modules/search/domain/usecases/search_by_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'modules/search/utils/github_result.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);
  test('> Deve recuperar o usecase em error', () {
    final usecase = Modular.get<SearchByText>();
    expect(usecase, isA<SearchByTextImpl>());
  });

  test('> Deve trazer uma lista de ResultSearch', () async {
    when(dio.get(any)).thenAnswer((_) async => Response(
          data: jsonDecode(githubResult),
          statusCode: 200,
          requestOptions: null,
        ));

    final usecase = Modular.get<SearchByText>();
    final result = await usecase('adao');

    expect(result | null, isA<List<ResultSearch>>());
  });
}
