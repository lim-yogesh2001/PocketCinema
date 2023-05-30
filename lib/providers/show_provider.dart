import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/moviesWatched.dart';
import '../const/static.dart';
import 'package:http/http.dart' as http;
import '../models/show.dart';

class ShowProvider with ChangeNotifier {
  List<Show> _showList = [];
  List<MoviesWatched> moviesWatchedList = [];

  get shows {
    return [..._showList];
  }

  List<MoviesWatched> moviesWatched() {
    return [...moviesWatchedList];
  }

  List<MoviesWatched> uniqueMoviesWatched(){
    var list = <String>{};
    List<MoviesWatched> uniquelist = moviesWatchedList.where((element) => list.add(element.movieName)).toList();
    return uniquelist;
  }

  Future<void> fetchShows(String id) async {
    final url = "$showsUrl/$id";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 || response.statusCode >= 200) {
        final extractedData = showFromJson(response.body);
        // if (extractedData.isEmpty) {
        //   return;
        // }
        _showList = extractedData;
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchHistoryOfShows(String userId) async {
    final url = "$historyOfShowsUrl/$userId";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200 && response.statusCode >= 200) {
        final extractedData = json.decode(response.body) as List<dynamic>;
        // if (extractedData.isEmpty){
        //   return;
        // }
        final list = extractedData
            .map(
              (e) => MoviesWatched.fromJson(e),
            )
            .toList();
        moviesWatchedList = list.toList();
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
