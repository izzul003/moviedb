import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie_detail.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovieList();
  Future<List<Movie>> getComingSoonMovieList();
  Future<MovieDetail?> getMovieDetail(int id);
  Future<List<Movie>> getFavorites();
  Future<List<Movie>> searchFavorite(String searchQuery);
  Future<Movie?> toggleFavorite(Movie movie);
}