import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:xoonideeplink/screen/home.dart';
import './firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snap) {
        if (snap.hasError) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            ),
          );
        }
        if (!snap.hasData) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        return MaterialApp(
          title: 'Deeplink Test',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
