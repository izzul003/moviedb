import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie_detail.dart';
import 'package:moviedb_elements/features/movie/domain/usecases/movie_use_case.dart';

part 'movie_detail_state.dart';
class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieUseCase _movieUseCase;
  MovieDetailCubit(this._movieUseCase) : super(MovieDetailInitial());

  MovieDetail? movieDetail;
  bool getMovieDetailLoading = false;

  List<Movie> favoriteList = [];
  bool getFavoriteListLoading = false;

  void getMovieDetail(int id) async {
    movieDetail = null;
    getMovieDetailLoading = true;
    emit(GetMovieDetailInit());

    MovieDetail? result = await _movieUseCase.getMovieDetail(id);
    if (result != null) {
      movieDetail = result;
      List<Movie> favoriteList = await _movieUseCase.getFavorites();
      movieDetail!.isFavorite = favoriteList.where((mv) => mv.id == result.id).isNotEmpty;
    }

    getMovieDetailLoading = false;
    emit(GetMovieDetailFailed());
  }

  void toggleFavorite(Movie movie) async {
    emit(ToggleFavoritesInit());

    try {
      Movie? result = await _movieUseCase.toggleFavorite(movie);
      emit(ToggleFavoritesSuccessful(result));

    } catch (e) {
      emit(ToggleFavoritesFailed());
    }
  }

}