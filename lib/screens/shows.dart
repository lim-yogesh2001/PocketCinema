import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/screens/show_details.dart';
import '../providers/show_provider.dart';
import 'package:provider/provider.dart';
import '../components/app_bar.dart';
import '../const/no_available.dart';

class ShowScreen extends StatelessWidget {
  final String id;
  const ShowScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    final showProvider = Provider.of<ShowProvider>(context, listen: false);
    return Scaffold(
      appBar: customAppBar(context, 'Shows'),
      body: SafeArea(
        child: FutureBuilder(
            future: showProvider.fetchShows(id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Consumer<ShowProvider>(
                builder: ((context, value, child) {
                  return value.shows.length == 0
                      ? NotAvailable(h, context, 'No Shows Available')
                      : ListView.builder(
                          // shrinkWrap: true,
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.shows.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                              child: Column(
                                children: [
                                  ListTile(
                                      onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (ctx) => SeatScreen(
                                                  show: value.shows[index]),
                                            ),
                                          ),
                                      leading: Image.network(
                                          value.shows[index].theater.logo),
                                      title: Text(
                                        value
                                            .shows[index].theater.theaterName,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        '${value.shows[index].theater.country},  ${value.shows[index].theater.city}',
                                        style: const TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white),
                                      ),
                                      trailing: value.shows[index].isHouseFull
                                          ? const Text(
                                              'Housefull',
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  color: Colors.red,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            )
                                          : null),
                                  const Divider(
                                    color: Colors.white24,
                                  ),
                                ],
                              ),
                            );
                          });
                }),
              );
            }),
      ),
    );
  }

  
}
