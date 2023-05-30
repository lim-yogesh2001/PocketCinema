class MoviesWatched {
  MoviesWatched({
    required this.movieName,
    required this.coverImage,
    required this.showId,
    required this.showTime,
    required this.date,
    required this.theaterName,
    required this.row,
    required this.number,
  });
  final String movieName;
  final String coverImage;
  final String showId;
  final String showTime;
  final String date;
  final String theaterName;
  final int row;
  final int number;
  
  factory MoviesWatched.fromJson(Map<String, dynamic> json) => MoviesWatched(
    movieName : json['movie_name'],
    coverImage : json['cover_image'],
    showId : json['show_id'],
    showTime : json['show_time'],
    date : json['date'],
    theaterName : json['theater_name'],
    row : json['row'],
    number : json['number'],
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['movie_name'] = movieName;
    _data['cover_image'] = coverImage;
    _data['show_id'] = showId;
    _data['show_time'] = showTime;
    _data['date'] = date;
    _data['theater_name'] = theaterName;
    _data['row'] = row;
    _data['number'] = number;
    return _data;
  }
}