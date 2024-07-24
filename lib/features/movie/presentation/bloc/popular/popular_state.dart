part of 'popular_cubit.dart';

abstract class PopularState extends Equatable {
  const PopularState();

  @override
  List<Object> get props => [];
}

class PopularInitial extends PopularState {}

class GetPopularMovieListInit extends PopularState {}
class GetPopularMovieListSuccessful extends PopularState {}