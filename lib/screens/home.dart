// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/providers/login_provider.dart';
import 'package:pocket_cinema_ticket/screens/movies_watched.dart';
import 'package:pocket_cinema_ticket/screens/profile.dart';
import 'package:pocket_cinema_ticket/screens/recommended.dart';
import 'package:pocket_cinema_ticket/screens/still_upcoming.dart';
import './movie_details.dart';
import '../components/custom_spacer.dart';
import '../providers/movie_provider.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';
import '../components/drawer_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: false);
    final _userId = Provider.of<LoginProvider>(context, listen: false).userId();
    return Scaffold(
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerItem(
                title: "Profile",
                func: () => Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => ProfileScreen(
                            userId: _userId,
                          )),
                ),
              ),
              DrawerItem(
                title: "Recommended",
                func: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const RecommendedScreen(),
                  ),
                ),
              ),
              DrawerItem(
                  title: "Your History",
                  func: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => MoviesWatchedScreen(userId: _userId),
                        ),
                      )),
              DrawerItem(
                title: "Logout",
                func: () => Provider.of<LoginProvider>(context, listen: false)
                    .logout(context),
              ),
            ],
          ),
        ),
      ),
      appBar: customAppBar(context, 'Pocket Cinema'),
      body: RefreshIndicator(
        onRefresh: () =>
            Provider.of<MovieProvider>(context, listen: false).fetchMovies(),
        child: SafeArea(
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Upcoming Movies',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              UpcomingMovies(movieProvider: movieProvider),
              CustomSpacer(
                vspace: 10.0,
                hspace: 10.0,
                child: Text('Now Showing',
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              FutureBuilder(
                  future: movieProvider.fetchMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: movieProvider.movies.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 2.0,
                          mainAxisSpacing: 2.0,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, i) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetails(
                                    movieId: movieProvider.movies[i].id),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(1.0),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18.0),
                                    child: SizedBox(
                                      height: 155,
                                      width: 155,
                                      child: Card(
                                        child: Image.network(
                                          movieProvider.movies[i].imageUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    movieProvider.movies[i].name,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingMovies extends StatelessWidget {
  const UpcomingMovies({
    super.key,
    required this.movieProvider,
  });

  final MovieProvider movieProvider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: movieProvider.fetchUpComingMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            height: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: movieProvider.upcomingMovies.length,
                itemBuilder: (context, int i) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (ctx) => UpcomingScreen(time:  movieProvider.upcomingMovies[i].releaseDate)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: SizedBox(
                              height: 180,
                              width: 150,
                              child: Image.network(
                                movieProvider.upcomingMovies[i].imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            movieProvider.upcomingMovies[i].name,
                            style: Theme.of(context).textTheme.titleSmall,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                          )
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
