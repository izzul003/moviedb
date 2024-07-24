
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/usecases/movie_use_case.dart';

part 'watch_list_state.dart';
class WatchListCubit extends Cubit<WatchListState> {
  MovieUseCase _movieUseCase;
  WatchListCubit(this._movieUseCase) : super(WatchListInitial());

  List<Movie> favoriteList = [];
  bool getFavoriteListLoading = false;

  void getFavoriteList({ String? searchQuery }) async {
    favoriteList.clear();
    getFavoriteListLoading = true;
    emit(GetFavoritesInit());

    List<Movie> result = searchQuery == null || searchQuery.isEmpty
        ? await _movieUseCase.getFavorites()
        : await _movieUseCase.searchFavorite(searchQuery);
    favoriteList.addAll(result);

    getFavoriteListLoading = false;
    emit(GetFavoritesSuccessful());
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