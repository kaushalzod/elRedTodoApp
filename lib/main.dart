import 'package:elredtodo/app/core/themes/theme.dart';
import 'package:elredtodo/app/modules/home/homepage.dart';
import 'package:elredtodo/app/modules/home/homeprovider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: textTheme,
        buttonTheme: buttonTheme,
        floatingActionButtonTheme: floatButtonTheme,
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
        create: (context) => HomeProvider(),
        builder: (context, child) => const HomePage(),
      ),
    );
  }
}
