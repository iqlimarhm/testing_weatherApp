import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testing/firestore_service.dart';
// import 'package:testing/main.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => HomePage();
}

class HomePage extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Mobile",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirestoreService().getUsers(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else {
                      List usersList = snapshot.data!.docs;
                      return SizedBox(
                        width: double.infinity,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: usersList.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshot =
                                usersList[index];
                            Map<String, dynamic> data =
                                documentSnapshot.data() as Map<String, dynamic>;
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Material(
                                color: Colors.purple[50],
                                elevation: 2,
                                borderRadius: BorderRadius.circular(5),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['email'] ??
                                          'Email not available'),
                                      SizedBox(width: 4),
                                      Text(data['full name'] ??
                                          'Fullname not available'),
                                      SizedBox(width: 4),
                                      Text(data['username'] ??
                                          'Username not available'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
