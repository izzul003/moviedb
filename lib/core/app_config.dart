import 'package:dio/dio.dart';
import 'package:moviedb_elements/core/database/flutter_movie_database.dart';

class AppConfig {
  static AppConfig? _instance;
  late FlutterMovieDatabase dbConnection;

  AppConfig.configure() {
    _instance = this;
  }

  factory AppConfig() {
    if (_instance == null) {
      throw UnimplementedError("App must be configured first.");
    }

    return _instance!;
  }

  Future<void> init() async {

    dbConnection = FlutterMovieDatabase.instance;
  }
}