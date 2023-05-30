import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:pocket_cinema_ticket/providers/profile.dart';
import './providers/login_provider.dart';
import './providers/register_provider.dart';
import './providers/seat_provider.dart';
import './screens/login.dart';
import '../providers/show_provider.dart';
import '../const/theme.dart';
import './providers/movie_provider.dart';
import 'package:provider/provider.dart';
import './const/imp_credentials.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: khaltiPublicKey,
      builder: (context, navigatorKey) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (ctx) => LoginProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => RegisterProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => ProfileProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => MovieProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => ShowProvider(),
            ),
            ChangeNotifierProvider(
              create: (ctx) => SeatProvider(),
            )
          ],
          child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Pocket Cinema',
              theme: customTheme(),
              home: const LoginScreen(),
              localizationsDelegates: const [KhaltiLocalizations.delegate]),
        );
      },
    );
  }
}
