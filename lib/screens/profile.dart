import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_cinema_ticket/components/app_bar.dart';
import 'package:pocket_cinema_ticket/components/profile&cred_form.dart';
import 'package:pocket_cinema_ticket/providers/profile.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  final int userId;
  const ProfileScreen({required this.userId, super.key});

  void customSheet(BuildContext context, String type) {
    Scaffold.of(context).showBottomSheet(
      (ctx) => ProfileCredentialForm(formtype: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final future = Provider.of<ProfileProvider>(context, listen: false)
        .fetchProfile(context, userId.toString());
    return Scaffold(
      appBar: customAppBar(context, "Profile Screen"),
      body: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<ProfileProvider>(builder: (context, value, child) {
              return Center(
                child: SizedBox(
                  height: h * .78,
                  width: w * .84,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircleAvatar(
                                radius: 70.0,
                                backgroundImage: NetworkImage(
                                    "https://images.pexels.com/photos/1131774/pexels-photo-1131774.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text(
                              'Full Name:   ${value.profileDetails.fullName.toString()}'),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                                'Email:   ${value.profileDetails.email.toString()}'),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                                'Phone:   ${value.profileDetails.phone.toString()}'),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                                'Username:   ${value.profileDetails.username.toString()}'),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Text(
                                'Date Joined:   ${DateFormat.yMMMMEEEEd().format(value.profileDetails.dateJoined!)}'),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                          Divider(
                            color: Colors.grey.shade300,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () => customSheet(context, "profile"),
                                  child: const Text("Edit Profile")),
                              const SizedBox(
                                width: 10.0,
                              ),
                              ElevatedButton(
                                  onPressed: () => customSheet(context, "change password"),
                                  child: const Text("Change Password")),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
          }),
    );
  }
}
