
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/usecases/movie_use_case.dart';

part 'popular_state.dart';
class PopularCubit extends Cubit<PopularState> {
  MovieUseCase _movieUseCase;
  PopularCubit(this._movieUseCase) : super(PopularInitial());

  List<Movie> popularMovieList = [];
  List<Movie> backupPopularMovieList = []; // for local search function
  bool getPopularMovieListLoading = false;

  void getPopularMovieList({ String? searchQuery }) async {
    getPopularMovieListLoading = true;
    emit(GetPopularMovieListInit());

    if (searchQuery != null && searchQuery.isNotEmpty) {
      List<Movie> searchResult = backupPopularMovieList.where((movie) {
        return movie.title.toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
      popularMovieList.clear();
      popularMovieList.addAll(searchResult);
    } else {
      popularMovieList.clear();
      backupPopularMovieList.clear();
      List<Movie> result = await _movieUseCase.getMovieList();
      popularMovieList.addAll(result.reversed);
      backupPopularMovieList.addAll(result.reversed);
    }

    getPopularMovieListLoading = false;
    emit(GetPopularMovieListSuccessful());
  }
}