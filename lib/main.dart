import 'package:contact_maneger/pages/contact_home.dart';
import 'package:contact_maneger/pages/new_contact.dart';
import 'package:contact_maneger/pages/contact_details_page.dart';
import 'package:contact_maneger/provider/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create:(context) => ContactProvider(),child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: ContactHome.routeNmae,
      routes: {
        ContactHome.routeNmae : (context) => const ContactHome(),
        NewContactPage.routeNmae : (context) => const NewContactPage(),
        DetailsPage.routeNmae : (context) => const DetailsPage(),
      },

    );
  }
}
