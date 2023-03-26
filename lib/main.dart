import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:elredtodo/app/core/utils/constant.dart';
import 'package:elredtodo/app/data/services/authservice.dart';
import 'package:elredtodo/app/modules/home/homepage.dart';
import 'package:elredtodo/app/modules/home/homeprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(create: (context) => AuthService()),
          ChangeNotifierProvider(
            create: (context) => HomeProvider(
              authService: Provider.of<AuthService>(context, listen: false),
            ),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.indigo,
              textTheme: textTheme,
              buttonTheme: buttonTheme,
              floatingActionButtonTheme: floatButtonTheme,
              useMaterial3: true,
            ),
            home: const HomePage(),
          );
        });
  }
}
