import 'package:flutter/material.dart';
// import 'package:testing/home.dart';
import 'package:testing/Login.dart';
// import 'package:testing/Register.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testing/HomePage.dart';
import 'package:testing/Register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // app = await Firebase.initializeApp(
  // options: DefaultFirebaseOptions.currentPlatform,
  // );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:452285468704:android:945c5397e78470c9a76c45',
      apiKey: 'AIzaSyA_jgn6nODHn-9Ia1WPBrW6anIy2NW1qpc',
      messagingSenderId: '452285468704',
      projectId: 'my-community-d948a',
    ),
  );
  runApp(HomePage());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Intro Screen Demo',
//       debugShowCheckedModeBanner: false,
//       home: Login(),
//     );
//   }
// }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 6, 10, 36),
      ),
    );
  }
}
