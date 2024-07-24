part of 'movie_detail_cubit.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class GetMovieDetailInit extends MovieDetailState {}

class GetMovieDetailSuccessful extends MovieDetailState {}

class GetMovieDetailFailed extends MovieDetailState {}

class ToggleFavoritesInit extends MovieDetailState {}

class ToggleFavoritesSuccessful extends MovieDetailState {
  final Movie? movie;

  const ToggleFavoritesSuccessful(this.movie);
}

class ToggleFavoritesFailed extends MovieDetailState {}

class GetFavoritesInit extends MovieDetailState {}

class GetFavoritesSuccessful extends MovieDetailState {}