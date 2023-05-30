import "package:flutter/material.dart";
import 'package:pocket_cinema_ticket/components/app_bar.dart';
import 'package:pocket_cinema_ticket/const/static.dart';
import 'package:pocket_cinema_ticket/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class RecommendedScreen extends StatelessWidget {
  const RecommendedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recommendedfuture = Provider.of<MovieProvider>(context, listen: false).fetchRecommendedMovies(context);
    return Scaffold(
      appBar: customAppBar(context, "Our Recommendation"),
      body: FutureBuilder(
          future: recommendedfuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<MovieProvider>(builder: (context, value, child) {
              return value.recommendedMovies.length == 0
                  ? Center(
                      child: Text("Sorry! No Movie Recommended To You", style: Theme.of(context).textTheme.titleMedium,),
                    )
                  : GridView.builder(
                      itemCount: value.recommendedMovies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                              crossAxisCount: 2),
                      itemBuilder: (context, int i) {
                        return Container(
                          margin: const EdgeInsets.all(1.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 155,
                                width: 160,
                                child: Card(
                                  child: Image.network(
                                    domain + 
                                    value.recommendedMovies[i].coverImage,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                value.recommendedMovies[i].movieName,
                                style: Theme.of(context).textTheme.titleSmall,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        );
                      });
            });
          }),
    );
  }
}
