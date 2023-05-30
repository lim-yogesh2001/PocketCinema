
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/providers/login_provider.dart';
import 'package:provider/provider.dart';
import '../models/recommended_movie.dart';
import '../models/movie.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> _upcomingMovies = [];

  List<RecommendedMovie> _recommendedMovies = [];

  get movies {
    return [..._movies];
  }

  void resetMovies() {
    _movies.clear();
    _upcomingMovies.clear();
  }

  get recommendedMovies{
    return [..._recommendedMovies];
  }

  List<Movie> get popularMovies {
    return _movies.where((element) => element.isPopular).toList();
  }

  getMovieById(int movieId){
    return _movies.firstWhere((element) => element.id == movieId);
  }

  get upcomingMovies {
    return [..._upcomingMovies];
  }

  Future<void> fetchMovies() async {
    const url = moviesListUrl;
    try {
      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
      });
      if (response.statusCode == 200 || response.statusCode >= 200) {
        final extractedData = movieFromJson(response.body);
        _movies = extractedData;
      }
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchUpComingMovies() async {
    const url = upcomingMoviesUrl;
    try {
      final response = await http.get(Uri.parse(url), headers: <String, String>{
        'Content-Type': 'application/json; charset-UTF-8',
      });
      if (response.statusCode == 200 || response.statusCode >= 200) {
        final extractedData = movieFromJson(response.body);
        _upcomingMovies = extractedData;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> fetchRecommendedMovies(BuildContext context) async {
    final userId = Provider.of<LoginProvider>(context, listen: false).userId();
    final url = "$recommendedMoviesUrl/$userId";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode >= 200){
        final extractedData = json.decode(response.body) as List<dynamic>;
        final list = extractedData.map((e) => RecommendedMovie.fromJson(e));
        _recommendedMovies = list.toList();
      }
      notifyListeners();
    } catch(e){
      rethrow;
    }
  }

}
