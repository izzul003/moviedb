
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie_detail.dart';
import 'package:moviedb_elements/features/movie/domain/repositories/movie_repository.dart';

class MovieUseCase {
  final MovieRepository _repository;

  MovieUseCase(this._repository);

  Future<List<Movie>> getMovieList() async {
    return await _repository.getMovieList();
  }

  Future<MovieDetail?> getMovieDetail(int id) async {
    return await _repository.getMovieDetail(id);
  }

  Future<List<Movie>> getFavorites() async {
    return await _repository.getFavorites();
  }

  Future<Movie?> toggleFavorite(Movie movie) async {
    return await _repository.toggleFavorite(movie);
  }

  Future<List<Movie>> searchFavorite(String movie) async {
    return await _repository.searchFavorite(movie);
  }
}