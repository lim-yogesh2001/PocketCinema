import "package:flutter/material.dart";
import 'package:pocket_cinema_ticket/components/show_card.dart';
import 'package:pocket_cinema_ticket/providers/show_provider.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';

class MoviesWatchedScreen extends StatelessWidget {
  final int userId;
  const MoviesWatchedScreen({required this.userId, super.key});

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<ShowProvider>(context, listen: false)
        .fetchHistoryOfShows(userId.toString());
    return Scaffold(
      appBar: customAppBar(context, "History Of Shows"),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<ShowProvider>(
                builder: (context, value, child) =>
                    value.moviesWatchedList.length == 0
                        ? Center(
                            child: Text(
                              "No History Available",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          )
                        : SingleChildScrollView(
                          child: Column(
                              children: value
                                  .uniqueMoviesWatched()
                                  .map(
                                    (e) => ShowCard(mw: e),
                                  )
                                  .toList()),
                        ));
          }),
    );
  }
}
