import 'package:dio/dio.dart';
import 'package:moviedb_elements/core/app_config.dart';
import 'package:moviedb_elements/core/models/api_return.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/responses/cast_response.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/responses/genre_response.dart';
import 'package:moviedb_elements/features/movie/data/data_sources/network/responses/movie_response.dart';

class MovieService {
  final Dio _client;

  MovieService(this._client);
  final String _accountId = '21400583';
  final String _apiKey = 'bede790d3d767fd8607a6a330b5c877f';

  Future<ApiReturn<List<MovieResponse>>> getMovieList() async {
    try {
      Response response = await _client.get(
          'discover/movie',
          queryParameters: {
            'api_key': _apiKey,
            'language': 'en-US',
            'sort_by': 'popularity.desc',
            'include_adult': false,
            'include_video': false,
            'page': 2,
          }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['results'] != null ? List.generate(response.data['results'].length, (index) {
            return MovieResponse.fromJson(response.data['results'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
          success: false,
          message: 'Something went wrong'
      );
    }
  }

  Future<ApiReturn<List<MovieResponse>>> getComingSoonMovieList() async {
    try {
      Response response = await _client.get(
          'discover/movie',
          queryParameters: {
            'api_key': _apiKey,
            'language': 'enUS',
            'sort_by': 'popularity.asc',
            'include_adult': false,
            'include_video': false,
            'page': 1,
            'year': DateTime(DateTime.now().year + 1).year,
          }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['results'] != null ? List.generate(response.data['results'].length, (index) {
            return MovieResponse.fromJson(response.data['results'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
          success: false,
          message: 'Something went wrong'
      );
    }
  }

  Future<ApiReturn<MovieDetailResponse>> getMovieDetail(int id) async {
    try {
      Response response = await _client.get(
          'movie/$id',
          queryParameters: {
            'api_key': _apiKey,
          }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: MovieDetailResponse.fromJson(response.data),
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
          success: false,
          message: 'Something went wrong'
      );
    }
  }

  Future<ApiReturn<List<CastResponse>>> getCast(int movieId) async {
    try {
      Response response = await _client.get(
          'movie/$movieId/credits',
          queryParameters: {
            'api_key': _apiKey,
          }
      );

      if (response.statusCode == 200) {
        return ApiReturn(
          success: true,
          data: response.data['cast'] != null ? List.generate(response.data['cast'].length, (index) {
            return CastResponse.fromJson(response.data['cast'][index]);
          }) : null,
        );
      }

      return ApiReturn(success: false, message: 'API Error Ocurred');
    } catch(e) {
      return ApiReturn(
          success: false,
          message: 'Something went wrong'
      );
    }
  }
}