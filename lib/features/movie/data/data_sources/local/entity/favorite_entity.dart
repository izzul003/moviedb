import 'package:moviedb_elements/core/database/base/entity_base.dart';
import 'package:moviedb_elements/features/movie/domain/models/movie.dart';

class FavoriteEntity extends Entity {
  int id;
  String imageUrl;
  String title;
  String genres;
  String year;

  FavoriteEntity({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.genres,
    required this.year,
  });

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['movie_id'] = id;
    data['image_url'] = imageUrl;
    data['title'] = title;
    data['genres'] = genres;
    data['year'] = year;
    return data;
  }

  Movie toDomain() => Movie(
      id: id,
      title: title,
      imageUrl: imageUrl,
      genres: genres,
      year: year,
      isFavorite: true
  );
}