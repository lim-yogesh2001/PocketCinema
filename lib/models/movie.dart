import 'dart:convert';
import 'package:pocket_cinema_ticket/const/static.dart';

List<Movie> movieFromJson(String str) =>
    List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

class Movie {
  final int id;
  final String name;
  final String imageUrl;
  final DateTime releaseDate;
  final String genres;
  final String director;
  final String producers;
  final String casts;
  final String description;
  final bool isUpcoming;
  final bool isPopular;
  final bool isRecommended;

  Movie({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.releaseDate,
    required this.genres,
    required this.director,
    required this.producers,
    required this.casts,
    required this.description,
    required this.isPopular,
    required this.isRecommended,
    required this.isUpcoming,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        name: json['movie_name'],
        imageUrl: domain + json['cover_image'],
        releaseDate: DateTime.parse(json['release_date']),
        genres: json['genres'],
        director: json['director'],
        producers: json['producers'],
        casts: json['casts'],
        description: json['descripton'],
        isPopular: json['is_popular'],
        isUpcoming: json['is_upcoming'],
        isRecommended: json['is_recommended'],
      );
}
