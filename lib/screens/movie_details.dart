import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_cinema_ticket/components/custom_spacer.dart';
import 'package:pocket_cinema_ticket/providers/movie_provider.dart';
import 'package:pocket_cinema_ticket/screens/shows.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';

class MovieDetails extends StatelessWidget {
  final int movieId;
  const MovieDetails({
    required this.movieId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    print(movieId);
    final movie = Provider.of<MovieProvider>(context, listen: false).getMovieById(movieId);
    return Scaffold(
      appBar: customAppBar(context, movie.name),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 280,
                  foregroundDecoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.7)),
                  child: Image.network(
                    movie.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 90,
                  top: 35,
                  child: SizedBox(
                    width: 180,
                    height: 220,
                    child: Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: Image.network(
                        movie.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomSpacer(
              vspace: 10.0,
              hspace: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.name,
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400),
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Genres:  ${movie.genres}',
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Producers:  ${movie.producers}',
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Director:  ${movie.director}',
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Release Date:  ${DateFormat.yMMMEd().format(movie.releaseDate)}',
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                  )
                ],
              ),
            ),
            CustomSpacer(
              vspace: 0,
              hspace: 10.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.orange),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    movie.description,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => ShowScreen(
                              id: movie.id.toString(),
                            ),
                          ),
                        ),
                    child: const Text('Available Shows')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
