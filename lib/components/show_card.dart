import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/const/static.dart';
import 'package:pocket_cinema_ticket/models/moviesWatched.dart';

class ShowCard extends StatelessWidget {
  final MoviesWatched mw;
  const ShowCard({required this.mw, super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.deepPurple])),
      child: Row(
        children: [
          SizedBox(
            width: w * .29,
            height: h * .25,
            child: Image.network(
              domain + mw.coverImage,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 5.0,
          ),
          SizedBox(
            width: w * .66,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Movie Name:   ${mw.movieName}",
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Theater:   ${mw.theaterName}",
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Ticket Number:   ${mw.number}",
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Time:   ${mw.showTime}",
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    "Date:   ${mw.date}",
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
