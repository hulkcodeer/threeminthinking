import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:threeminthinking/features/home/data/datasources/home_supabase_data_source.dart';
import 'package:threeminthinking/features/home/domain/repositories/home_repository.dart';

part 'home_repository_impl.g.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeSupabaseDataSource _dataSource;

  HomeRepositoryImpl(
    this._dataSource,
  );
}

@riverpod
HomeRepositoryImpl homeRepository(HomeRepositoryRef ref) {
  return HomeRepositoryImpl(
    ref.watch(homeSupabaseDataSourceProvider),
  );
}
