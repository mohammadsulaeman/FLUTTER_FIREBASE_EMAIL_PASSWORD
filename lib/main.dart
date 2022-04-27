import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_email/pages/login.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialitation = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialitation,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print('somenthing was error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FLutter Email & Password',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: LoginPage(),
        );
      },
    );
  }
}
