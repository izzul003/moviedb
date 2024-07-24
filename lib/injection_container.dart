
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moviedb_elements/core/app_config.dart';
import 'package:moviedb_elements/core/network/app_network.dart';
import 'package:moviedb_elements/core/res/theme_cubit.dart';
import 'package:moviedb_elements/features/home/domain/home_use_case.dart';
import 'package:moviedb_elements/features/home/presentation/bloc/home_cubit.dart';
import 'package:moviedb_elements/features/main/presentation/bloc/main_cubit.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/movie_service.dart';
import 'package:moviedb_elements/features/movie/data/repository_impl/movie_repository_impl.dart';
import 'package:moviedb_elements/features/movie/domain/repositories/movie_repository.dart';
import 'package:moviedb_elements/features/movie/domain/usecases/movie_use_case.dart';
import 'package:moviedb_elements/features/movie/presentation/bloc/movie_detail/movie_detail_cubit.dart';
import 'package:moviedb_elements/features/movie/presentation/bloc/popular/popular_cubit.dart';
import 'package:moviedb_elements/features/movie/presentation/bloc/watch_list/watch_list_cubit.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<Dio>(AppNetworkClient.dio);

  //cubit
  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  sl.registerLazySingleton<MainCubit>(() => MainCubit());
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(sl()));
  sl.registerLazySingleton<PopularCubit>(() => PopularCubit(sl()));
  sl.registerLazySingleton<MovieDetailCubit>(() => MovieDetailCubit(sl()));
  sl.registerLazySingleton<WatchListCubit>(() => WatchListCubit(sl()));

  //data sources
  sl.registerLazySingleton(() => MovieService(sl()));

  // Repositories
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => HomeUseCase(sl()));
  sl.registerLazySingleton(() => MovieUseCase(sl()));
}