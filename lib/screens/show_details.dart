import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/screens/payment.dart';
import '../components/custom_spacer.dart';
import '../models/show.dart';
import 'package:provider/provider.dart';
import '../providers/seat_provider.dart';
import '../components/app_bar.dart';
import '../const/no_available.dart';

class SeatScreen extends StatefulWidget {
  final Show show;
  const SeatScreen({required this.show, super.key});

  @override
  State<SeatScreen> createState() => _SeatScreenState();
}

class _SeatScreenState extends State<SeatScreen> {
  bool _isLoading = false;
  final seatController = TextEditingController();

  String dropdownValue = "";

  onChange(BuildContext context, value) {
    final val = int.parse(value);
    seatController.text = Provider.of<SeatProvider>(context, listen: false)
        .getSeatById(val)
        .id
        .toString();
    print(seatController.text);
  }

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<SeatProvider>(context, listen: false).fetchSeats(
      widget.show.theater.id.toString(),
    );
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: customAppBar(context, 'Show Details'),
      body: widget.show.isHouseFull
          ? NotAvailable(h, context, "SORRY WE ARE HOUSEFULL !!")
          : SingleChildScrollView(
              child: Column(
                children: [
                  CustomSpacer(
                    vspace: 10.0,
                    hspace: 10.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                widget.show.theater.logo,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  widget.show.theater.theaterName,
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.orange),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Contact:  ${widget.show.theater.contact}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Street:  ${widget.show.theater.street}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'Seats:  ${widget.show.theater.totalSeats}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            )
                          ],
                        ),
                        CustomSpacer(
                          hspace: 5.0,
                          vspace: 10.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Show Details',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                'Time:  ${widget.show.showTime}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: 250,
                                height: 30,
                                child: Text(
                                  'Movie:  ${widget.show.movie.movieName}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                width: 250,
                                height: 30,
                                child: Text(
                                  'Language:  ${widget.show.langauge}',
                                  style: Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              const SizedBox(
                                height: 40.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Seat Selection',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      FutureBuilder(
                                        future: future,
                                        builder: (BuildContext context,
                                            AsyncSnapshot<dynamic> snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          }
                                          return Consumer<SeatProvider>(
                                            builder:
                                                (context, seatProv, child) {
                                              return DropdownButton(
                                                  value: dropdownValue.isEmpty
                                                      ? null
                                                      : dropdownValue,
                                                  hint: const Text(
                                                    'Select a seat',
                                                    style: TextStyle(
                                                        color: Colors.orange),
                                                  ),
                                                  icon: const Icon(Icons
                                                      .arrow_downward_rounded),
                                                  style: const TextStyle(
                                                      color: Colors.orange),
                                                  items: seatProv.seats
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                        (e) => DropdownMenuItem(
                                                          value:
                                                              e.id.toString(),
                                                          child: Text(
                                                              'Row Number- ${e.row}, Seat Number- ${e.number}'),
                                                        ),
                                                      )
                                                      .toList(),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      dropdownValue = value!;
                                                    });
                                                    onChange(context, value);
                                                  });
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      _isLoading == true
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ElevatedButton(
                                              onPressed: () async {
                                                if (seatController
                                                    .text.isNotEmpty) {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  await Provider.of<
                                                              SeatProvider>(
                                                          context,
                                                          listen: false)
                                                      .setReserveSeat(
                                                          context,
                                                          widget.show.id,
                                                          int.parse(
                                                              seatController
                                                                  .text));
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(MaterialPageRoute(
                                                    builder: (ctx) =>
                                                        PaymentScreen(
                                                      show: widget.show,
                                                      seatId: int.parse(
                                                          seatController.text),
                                                    ),),
                                                    (routes) => false
                                                    );  
                                          
                                                }
                                              },
                                              child: const Text('Buy Now'),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
