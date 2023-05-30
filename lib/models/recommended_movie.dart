class RecommendedMovie {
  RecommendedMovie({
    required this.id,
    required this.movieName,
    required this.coverImage,
    required this.releaseDate,
    required this.genres,
    required this.director,
    required this.producers,
    required this.casts,
    required this.descripton,
    required this.isUpcoming,
    required this.isPopular,
    required this.isRecommended,
  });
  final int id;
  final String movieName;
  final String coverImage;
  final String releaseDate;
  final String genres;
  final String director;
  final String producers;
  final String casts;
  final String descripton;
  final bool isUpcoming;
  final bool isPopular;
  final bool isRecommended;
  
  factory RecommendedMovie.fromJson(Map<String, dynamic> json) => RecommendedMovie(
    id : json['id'],
    movieName : json['movie_name'],
    coverImage : json['cover_image'],
    releaseDate : json['release_date'],
    genres : json['genres'],
    director : json['director'],
    producers : json['producers'],
    casts : json['casts'],
    descripton : json['descripton'],
    isUpcoming : json['is_upcoming'],
    isPopular : json['is_popular'],
    isRecommended : json['is_recommended'],
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['movie_name'] = movieName;
    _data['cover_image'] = coverImage;
    _data['release_date'] = releaseDate;
    _data['genres'] = genres;
    _data['director'] = director;
    _data['producers'] = producers;
    _data['casts'] = casts;
    _data['descripton'] = descripton;
    _data['is_upcoming'] = isUpcoming;
    _data['is_popular'] = isPopular;
    _data['is_recommended'] = isRecommended;
    return _data;
  }
}