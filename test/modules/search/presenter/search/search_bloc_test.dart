import 'package:clean_architecture_class/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_class/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_class/modules/search/domain/usecases/search_by_text.dart';
import 'package:clean_architecture_class/modules/search/presenter/search/search_bloc.dart';
import 'package:clean_architecture_class/modules/search/presenter/search/states/state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class SearchTextMock extends Mock implements SearchByText {}

main() {
  final usecase = SearchTextMock();
  final bloc = SearchBloc(usecase);

  test('> Deve retornar os estados na ordem correta', () {
    when(usecase.call(any)).thenAnswer(
      (_) async => Right(<ResultSearch>[]),
    );
    expect(
      bloc,
      emitsInOrder(
        [isA<SearchLoading>(), isA<SearchSuccess>()],
      ),
    );
    bloc.add('adao');
  });

  test('> Deve retornar error', () {
    when(usecase.call(any)).thenAnswer((_) async => Left(InvalidTextError()));
    expect(
      bloc,
      emitsInOrder(
        [isA<SearchLoading>(), isA<SearchError>()],
      ),
    );
    bloc.add('adao');
  });
}
