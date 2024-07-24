part of 'watch_list_cubit.dart';

abstract class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

class WatchListInitial extends WatchListState {}

class GetFavoritesInit extends WatchListState {}
class GetFavoritesSuccessful extends WatchListState {}

class ToggleFavoritesInit extends WatchListState {}

class ToggleFavoritesSuccessful extends WatchListState {
  final Movie? movie;

  const ToggleFavoritesSuccessful(this.movie);
}

class ToggleFavoritesFailed extends WatchListState {}