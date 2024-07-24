
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/repositories/movie_repository.dart';

class HomeUseCase {
  final MovieRepository _repository;

  HomeUseCase(this._repository);

  Future<List<Movie>> getMovieList() async {
    return await _repository.getMovieList();
  }

  Future<List<Movie>> getComingSoonMovieList() async {
    return await _repository.getComingSoonMovieList();
  }
}