import 'package:clean_architecture_class/modules/search/domain/errors/errors.dart';
import 'package:clean_architecture_class/modules/search/domain/entities/result_search.dart';
import 'package:clean_architecture_class/modules/search/domain/repositories/search_repository.dart';
import 'package:clean_architecture_class/modules/search/infra/datasource/search_datasouce.dart';
import 'package:dartz/dartz.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DataSourceError());
    }
  }
}
