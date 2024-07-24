
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moviedb_elements/features/home/domain/home_use_case.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';

part 'home_state.dart';
class HomeCubit extends Cubit<HomeState> {
  HomeUseCase _homeUseCase;
  HomeCubit(this._homeUseCase) : super(HomeInitial());

  List<Movie> highlightMovieList = [];
  List<Movie> movieList = [];
  List<Movie> comingSoonList = [];
  bool getMovieListLoading = false;

  void getMovieList() async {
    getMovieListLoading = true;
    emit(GetMovieListInit());

    highlightMovieList.clear();
    movieList.clear();
    List<Movie> result = await _homeUseCase.getMovieList();
    highlightMovieList = result.sublist(0, 3);
    movieList = result.sublist(3, 13);

    comingSoonList.clear();
    List<Movie> resultComingSoonMovie  = await _homeUseCase.getComingSoonMovieList();
    comingSoonList = resultComingSoonMovie.sublist(0, 10);

    getMovieListLoading = false;
    emit(GetMovieListSuccessful());
  }
}