import 'package:moviedb_elements/core/models/api_return.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/local/dao/favorite_dao.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/local/entity/favorite_entity.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/movie_service.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/responses/cast_response.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/responses/genre_response.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/responses/movie_response.dart';
import 'package:moviedb_elements/features/movie/domain/models/cast.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie_detail.dart';
import 'package:moviedb_elements/features/movie/domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieService movieService;
  FavoriteDao _favoriteDao = FavoriteDao();

  MovieRepositoryImpl(this.movieService);


  @override
  Future<List<Movie>> getMovieList() async {
    ApiReturn<List<MovieResponse>> result = await movieService.getMovieList();
    if (result.success) {
      List<Movie> res = [];
      result.data?.forEach((MovieResponse e) {
        res.add(e.toDomain());
      });

      return res;
    } else {
      return [];
    }
  }

  @override
  Future<List<Movie>> getComingSoonMovieList() async{
    ApiReturn<List<MovieResponse>> result = await movieService.getComingSoonMovieList();
    if (result.success) {
      List<Movie> res = [];
      result.data?.forEach((MovieResponse e) {
        res.add(e.toDomain());
      });

      return res;
    } else {
      return [];
    }
  }


  @override
  Future<MovieDetail?> getMovieDetail(int id) async {
    ApiReturn<MovieDetailResponse> result = await movieService.getMovieDetail(id);
    if (result.success) {
      var res = (result.data as MovieDetailResponse).toDomain();

      ApiReturn<List<CastResponse>> castResult = await movieService.getCast(id);
      List<Cast> casTemp = [];
      castResult.data?.forEach((CastResponse e) {
        casTemp.add(e.toDomain());
      });

      res.casts = casTemp;
      return res;
    } else {
      return null;
    }
  }

  @override
  Future<List<Movie>> getFavorites() async {
    List result = await _favoriteDao.query();
    return result.cast<FavoriteEntity>().map((FavoriteEntity e) => e.toDomain()).toList();
  }

  @override
  Future<List<Movie>> searchFavorite(String searchQuery) async {
    List result = await _favoriteDao.rawQuery("SELECT * FROM favorite WHERE title LIKE '%$searchQuery%'");
    return result.cast<FavoriteEntity>().map((FavoriteEntity e) => e.toDomain()).toList();
  }

  @override
  Future<Movie?> toggleFavorite(Movie movie) async {
    try {
      FavoriteEntity entity = FavoriteEntity(
          id: movie.id,
          imageUrl: movie.imageUrl,
          title: movie.title,
          genres: movie.genres,
          year: movie.year
      );

      if (movie.isFavorite) {
        await _favoriteDao.rawQuery("DELETE FROM favorite WHERE movie_id = ${movie.id}");
      } else {
        await _favoriteDao.insert(entity);
      }

      List result = await _favoriteDao.query(where: 'movie_id = ?', whereArgs: [entity.id]);
      return result.cast<FavoriteEntity>().map((FavoriteEntity e) => e.toDomain()).toList().firstOrNull;
    } catch (e) {
      rethrow;
    }
  }

}